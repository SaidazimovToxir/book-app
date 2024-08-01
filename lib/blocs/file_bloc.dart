import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book/data/models/file_models.dart';
import 'package:book/data/repositories/file_repositories.dart';
import 'package:book/service/storage_permission.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
part 'file_state.dart';
part 'file_event.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc({required this.fileRepositories}) : super(FileState()) {
    on<GetFile>(_onGetFile);
    on<DownloadFile>(_onDownloadFile);
    on<OpenFile>(_onOpenFile);
    on<SearchFile>(_onSearchFile);
  }
  final FileRepositories fileRepositories;

  void _onGetFile(
    GetFile event,
    Emitter<FileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // await Future.delayed(const Duration(seconds: 1));
      for (var file in fileRepositories.files) {
        final fullPath = await _getSavePath(file);
        if (_checkFileExists(fullPath)) {
          file = file
            ..savePath = fullPath
            ..isDownloaded = true;
        }
      }

      emit(state.copyWith(
        files: fileRepositories.files,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchFile(SearchFile event, Emitter<FileState> emit) {
    final files = state.files;
    if (files != null) {
      final results = files.where((pdf) {
        final searchLower = event.query.toLowerCase();
        return pdf.title.toLowerCase().contains(searchLower) ||
            pdf.description.toLowerCase().contains(searchLower);
      }).toList();
      emit(state.copyWith(searchResults: results));
    }
  }

  void _onDownloadFile(
    DownloadFile event,
    Emitter<FileState> emit,
  ) async {
    final file = event.file;
    file.isLoading = true;

    emit(state.copyWith(file: file));

    final dio = Dio();

    if (await StoragePermission.requestStorage()) {
      try {
        final fullPath = await _getSavePath(file);

        if (_checkFileExists(fullPath)) {
          add(OpenFile(path: fullPath));
          emit(
            state.copyWith(
              file: state.file!
                ..savePath = fullPath
                ..isLoading = false
                ..isDownloaded = true,
            ),
          );
        } else {
          final response = await dio.download(
            file.fileUrl,
            fullPath,
            onReceiveProgress: (count, total) {
              emit(state.copyWith(
                file: state.file!..progres = count / total,
              ));
            },
          );

          print(response);

          emit(
            state.copyWith(
              file: state.file!
                ..savePath = fullPath
                ..isLoading = false
                ..isDownloaded = true,
            ),
          );
        }
      } on DioException catch (e) {
        print("DIO EXCEPTION");
        emit(
          state.copyWith(
            file: state.file!..isLoading = false,
            errorMessage: e.response?.data,
          ),
        );
      } catch (e) {
        print("DIO EXCEPTION");
        emit(
          state.copyWith(
            file: state.file!..isLoading = false,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  void _onOpenFile(
    OpenFile event,
    Emitter<FileState> emit,
  ) async {
    await OpenFilex.open(event.path);
  }

  bool _checkFileExists(String filePath) {
    final file = File(filePath);

    return file.existsSync();
  }

  void deleteFile(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      try {
        await file.delete();
      } catch (e) {
        emit(state.copyWith(
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<String> _getSavePath(FileModels file) async {
    final savePath =
        await getApplicationDocumentsDirectory(); // iphone/application/documents
    final fileExtension = file.fileUrl.split('.').last;
    final fileName = "${file.title}.$fileExtension"; // Harry Potter Video.mp4
    final fullPath = "${savePath.path}/$fileName";

    return fullPath;
  }
}
