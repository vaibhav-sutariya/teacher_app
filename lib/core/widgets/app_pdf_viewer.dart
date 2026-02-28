import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';

class AppPdfViewer extends StatefulWidget {
  final String filePath;

  const AppPdfViewer({super.key, required this.filePath});

  @override
  State<AppPdfViewer> createState() => _AppPdfViewerState();
}

class _AppPdfViewerState extends State<AppPdfViewer> {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return Stack(
      children: [
        PDFView(
          filePath: widget.filePath,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: false,
          pageSnap: false,
          defaultPage: currentPage!,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
          onRender: (pages) {
            setState(() {
              pages = pages;
              isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              errorMessage = error.toString();
            });
          },
          onPageError: (page, error) {
            setState(() {
              errorMessage = '$page: ${error.toString()}';
            });
          },
          onViewCreated: (PDFViewController pdfViewController) {
            // Controller can be used for programmatic navigation
          },
          onPageChanged: (int? page, int? total) {
            currentPage = page;
          },
        ),
        if (!isReady) const Center(child: AppLoader()),
      ],
    );
  }
}
