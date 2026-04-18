import '../models/concern_model.dart';

abstract class ConcernRepository {
  Future<List<ConcernModel>> getConcerns();
  Future<void> resolveConcern({
    required String concernId,
    required ConcernStatus status,
    required String resolution,
    required List<String> proofImages,
  });
}

class MockConcernRepository implements ConcernRepository {
  static final List<ConcernModel> _mockConcerns = ConcernModel.getMockData();

  @override
  Future<List<ConcernModel>> getConcerns() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.from(_mockConcerns);
  }

  @override
  Future<void> resolveConcern({
    required String concernId,
    required ConcernStatus status,
    required String resolution,
    required List<String> proofImages,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final index = _mockConcerns.indexWhere((c) => c.id == concernId);
    if (index != -1) {
      _mockConcerns[index] = _mockConcerns[index].copyWith(
        status: status,
        resolution: resolution,
        resolutionDate: DateTime.now(),
        proofImages: proofImages,
      );
    }
  }
}
