class ReportCardModel {
  final String id;
  final String termName;
  final String status; // e.g., 'PASSED', 'AVAILABLE SOON'
  final String date;
  final String? grade; // e.g., 'A+', 'A'
  final String? overallGradeLabel; // e.g., 'OVERALL GRADE'
  final String? pdfUrl;
  final bool isLocked;
  final String? lockMessage;

  const ReportCardModel({
    required this.id,
    required this.termName,
    required this.status,
    required this.date,
    this.grade,
    this.overallGradeLabel,
    this.pdfUrl,
    this.isLocked = false,
    this.lockMessage,
  });

  // Mock data generator
  static List<ReportCardModel> getMockData(String year) {
    const basePdfUrl =
        'https://online.op.ac.nz/assets/LearningAdvice/99ab78acca/Weekly-study-timetable.pdf';

    if (year == '2023 - 2024') {
      return [
        const ReportCardModel(
          id: '1_23',
          termName: 'First Term Examination',
          status: 'PASSED',
          date: 'Oct 2023',
          grade: 'A',
          overallGradeLabel: 'OVERALL GRADE',
          pdfUrl: basePdfUrl,
          isLocked: false,
        ),
        const ReportCardModel(
          id: '2_23',
          termName: 'Second Term Examination',
          status: 'PASSED',
          date: 'Jan 2024',
          grade: 'B+',
          overallGradeLabel: 'OVERALL GRADE',
          pdfUrl: basePdfUrl,
          isLocked: false,
        ),
        const ReportCardModel(
          id: '3_23',
          termName: 'Annual Final Examination',
          status: 'PASSED',
          date: 'Mar 2024',
          grade: 'A-',
          overallGradeLabel: 'OVERALL GRADE',
          pdfUrl: basePdfUrl,
          isLocked: false,
        ),
      ];
    } else if (year == '2024 - 2025') {
      return [
        const ReportCardModel(
          id: '1',
          termName: 'First Term Examination',
          status: 'PASSED',
          date: 'Oct 2024',
          grade: 'A+',
          overallGradeLabel: 'OVERALL GRADE',
          pdfUrl: basePdfUrl,
          isLocked: false,
        ),
        const ReportCardModel(
          id: '2',
          termName: 'Second Term Examination',
          status: 'PASSED',
          date: 'Jan 2025',
          grade: 'A',
          overallGradeLabel: 'OVERALL GRADE',
          pdfUrl: basePdfUrl,
          isLocked: false,
        ),
        const ReportCardModel(
          id: '3',
          termName: 'Annual Final Examination',
          status: 'AVAILABLE SOON',
          date: '',
          isLocked: true,
          lockMessage:
              'Final results are being processed. Expected publication date: June 15, 2025.',
        ),
      ];
    }
    return [];
  }
}
