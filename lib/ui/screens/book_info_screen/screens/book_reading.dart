import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookReading extends StatelessWidget {
  final String url;
  const BookReading({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PDF(
        enableSwipe: true,
        nightMode: false,
        swipeHorizontal: true,
      ).cachedFromUrl(
        url,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
