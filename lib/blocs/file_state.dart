part of 'file_bloc.dart';

final class FileState {
  List<FileModels>? files;
  FileModels? file;
  String? errorMessage;
  bool isLoading;
     List<FileModels>? searchResults;


  FileState({
    this.file,
    this.errorMessage,
    this.isLoading = false,
    this.files,
    this.searchResults,
  });

  FileState copyWith({
    FileModels? file,
    String? errorMessage,
    bool? isLoading,
    List<FileModels>? files,
         List<FileModels>? searchResults,

  }) {
    return FileState(
      file: file ?? this.file,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      files: files ?? this.files,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
