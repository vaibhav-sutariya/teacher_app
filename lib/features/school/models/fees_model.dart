import 'package:equatable/equatable.dart';

enum FeesPaymentStatus { paid, pending, partial }

enum FeesPaymentMode { cash, online, cheque }

class FeesCollectionModel extends Equatable {
  final String id;
  final String studentName;
  final String studentClass;
  final String receiptNumber;
  final double amount;
  final DateTime date;
  final FeesPaymentStatus status;
  final FeesPaymentMode paymentMode;

  const FeesCollectionModel({
    required this.id,
    required this.studentName,
    required this.studentClass,
    required this.receiptNumber,
    required this.amount,
    required this.date,
    required this.status,
    required this.paymentMode,
  });

  @override
  List<Object?> get props => [
        id,
        studentName,
        studentClass,
        receiptNumber,
        amount,
        date,
        status,
        paymentMode,
      ];
}

class FeesSummaryModel extends Equatable {
  final double totalExpected;
  final double totalCollected;
  final double totalPending;
  final int totalStudents;

  const FeesSummaryModel({
    required this.totalExpected,
    required this.totalCollected,
    required this.totalPending,
    required this.totalStudents,
  });

  @override
  List<Object?> get props => [
        totalExpected,
        totalCollected,
        totalPending,
        totalStudents,
      ];

  static FeesSummaryModel mock(DateTime month) {
    // Return different data based on month for demonstration
    final isMarch = month.month == 3;
    return FeesSummaryModel(
      totalExpected: isMarch ? 2500000 : 2000000,
      totalCollected: isMarch ? 1850400 : 1200000,
      totalPending: isMarch ? 649600 : 800000,
      totalStudents: 450,
    );
  }

  static List<FeesCollectionModel> mockCollections(DateTime month) {
    final year = month.year;
    final m = month.month;
    return [
      FeesCollectionModel(
        id: '1',
        studentName: 'Aarav Sharma',
        studentClass: 'X-A',
        receiptNumber: 'REC-2024-001',
        amount: 25000.0,
        date: DateTime(year, m, 10, 10, 30),
        status: FeesPaymentStatus.paid,
        paymentMode: FeesPaymentMode.online,
      ),
      FeesCollectionModel(
        id: '2',
        studentName: 'Ishani Patel',
        studentClass: 'VIII-B',
        receiptNumber: 'REC-2024-002',
        amount: 15000.0,
        date: DateTime(year, m, 12, 14, 15),
        status: FeesPaymentStatus.paid,
        paymentMode: FeesPaymentMode.cash,
      ),
      FeesCollectionModel(
        id: '3',
        studentName: 'Vihaan Gupta',
        studentClass: 'XII-C',
        receiptNumber: 'REC-2024-003',
        amount: 32000.0,
        date: DateTime(year, m, 15, 09, 45),
        status: FeesPaymentStatus.partial,
        paymentMode: FeesPaymentMode.online,
      ),
      FeesCollectionModel(
        id: '4',
        studentName: 'Ananya Reddy',
        studentClass: 'V-A',
        receiptNumber: 'REC-2024-004',
        amount: 12000.0,
        date: DateTime(year, m, 18, 11, 20),
        status: FeesPaymentStatus.paid,
        paymentMode: FeesPaymentMode.cheque,
      ),
      FeesCollectionModel(
        id: '5',
        studentName: 'Reyansh Verma',
        studentClass: 'III-B',
        receiptNumber: 'REC-2024-005',
        amount: 12000.0,
        date: DateTime(year, m, 20, 16, 05),
        status: FeesPaymentStatus.pending,
        paymentMode: FeesPaymentMode.cash,
      ),
    ];
  }
}
