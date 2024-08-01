import 'package:book/blocs/file_bloc.dart';
import 'package:book/data/models/file_models.dart';
import 'package:book/ui/screens/book_info_screen/screens/book_reading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoScreen extends StatelessWidget {
  final FileModels book;
  const BookInfoScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bookBloc = context.read<FileBloc>();
    double appBarHeight = 400;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<FileBloc, FileState>(
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
                    child: Text("Fayllar mavjud emas"),
                  );
                }

                final file = state.files!.firstWhere(
                  (element) => element.title == book.title,
                );

                return FloatingActionButton(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {
                    context.read<FileBloc>().add(DownloadFile(file: book));
                  },
                  child: file.isLoading
                      ? CircularProgressIndicator(
                          value: file.progres,
                        )
                      : file.isDownloaded
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.cloud_download_outlined),
                );
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: const Size(double.infinity, 90),
                  backgroundColor: const Color(0xff404066),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookReading(url: book.fileUrl),
                    ),
                  );
                },
                child: const Text("O'qish"),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Image.asset("assets/icons/arrow_back.png"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            pinned: true,
            expandedHeight: appBarHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    book.image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.8),
                  ),
                  Align(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 200,
                      height: 300,
                      child: Image.network(
                        book.image,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.5),
                      offset: const Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 250,
                height: 50,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffFFF8E0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xffFCC400),
                              size: 17,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: '',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color(0xffE2FCFB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(book.category),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "432",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "pages",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    book.description,
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
