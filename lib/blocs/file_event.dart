part of 'file_bloc.dart';

sealed class FileEvent {}

final class GetFile extends FileEvent {}

final class DownloadFile extends FileEvent {
  final FileModels file;
  DownloadFile({required this.file});
}

final class OpenFile extends FileEvent {
  final String path;
  OpenFile({required this.path});
}

class SearchFile extends FileEvent {
  final String query;

  SearchFile(this.query);
}
