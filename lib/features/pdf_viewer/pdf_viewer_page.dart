import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/widgets/app_app_bar.dart';
import '../../core/widgets/app_loader.dart';
import '../../core/widgets/app_pdf_viewer.dart';
import 'bloc/pdf_bloc.dart';

@RoutePage()
class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerPage({super.key, required this.pdfUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PdfBloc(repository: sl())..add(LoadPdf(pdfUrl)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppAppBar(title: title),
        body: BlocBuilder<PdfBloc, PdfState>(
          builder: (context, state) {
            if (state is PdfLoading) {
              return const Center(child: AppLoader());
            } else if (state is PdfLoaded) {
              return AppPdfViewer(filePath: state.filePath);
            } else if (state is PdfError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
