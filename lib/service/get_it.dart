import 'package:book/blocs/file_bloc.dart';
import 'package:book/data/repositories/file_repositories.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton(FileRepositories());

  getIt.registerSingleton(
    FileBloc(
      fileRepositories: getIt.get<FileRepositories>()
    ),
  );
}
