import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/pdf_document_card.dart';
import 'bloc/class_test_bloc.dart';

@RoutePage()
class ClassTestPage extends StatelessWidget {
  const ClassTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassTestBloc()..add(ClassTestLoaded()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AppAppBar(title: 'Class Test'),
        body: BlocBuilder<ClassTestBloc, ClassTestState>(
          builder: (context, state) {
            if (state is ClassTestLoading) {
              return const Center(child: AppLoader());
            } else if (state is ClassTestLoadedState) {
              if (state.classTestList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: context.scale(64),
                        color: Colors.grey.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      Text(
                        'No Class Tests Available',
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
                itemCount: state.classTestList.length,
                itemBuilder: (context, index) {
                  final test = state.classTestList[index];
                  return PdfDocumentCard(
                    id: test.id,
                    date: test.date,
                    subject: test.subject,
                    type: test.type,
                    color: test.color,
                    pdfUrl: test.pdfUrl,
                    icon: Icons.quiz_outlined,
                  );
                },
              );
            } else if (state is ClassTestError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
