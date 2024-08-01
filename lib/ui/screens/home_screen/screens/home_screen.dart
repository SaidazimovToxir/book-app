import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book/blocs/file_bloc.dart';
import 'package:book/ui/screens/home_screen/widgets/category_button.dart';
import 'package:book/ui/screens/home_screen/widgets/search_bar.dart';
import '../../../../data/models/file_models.dart';
import '../widgets/books_grid.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: BlocBuilder<FileBloc, FileState>(
        bloc: context.read<FileBloc>()..add(GetFile()),
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.errorMessage != null) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }
          if (state.files == null || state.files!.isEmpty) {
            return const Center(
              child: Text("Files not available"),
            );
          }
          final files = state.files!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SearchBarWidget(),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CategoryButtons(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BooksGrid(files: files),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
