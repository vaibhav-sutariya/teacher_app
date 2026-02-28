import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/pdf_document_card.dart';
import 'bloc/paper_bloc.dart';

@RoutePage()
class PaperPage extends StatelessWidget {
  const PaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaperBloc()..add(PaperLoaded()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AppAppBar(title: 'Paper'),
        body: BlocBuilder<PaperBloc, PaperState>(
          builder: (context, state) {
            if (state is PaperLoading) {
              return const Center(child: AppLoader());
            } else if (state is PaperLoadedState) {
              if (state.paperList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: context.scale(64),
                        color: Colors.grey.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      Text(
                        'No Papers Available',
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(16)),
                itemCount: state.paperList.length,
                itemBuilder: (context, index) {
                  final paper = state.paperList[index];
                  return PdfDocumentCard(
                    id: paper.id,
                    date: paper.date,
                    subject: paper.subject,
                    type: paper.type,
                    color: paper.color,
                    pdfUrl: paper.pdfUrl,
                    icon: Icons.description_outlined,
                  );
                },
              );
            } else if (state is PaperError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
