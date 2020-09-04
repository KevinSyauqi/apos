import 'package:apos/src/provider/predictionProvider.dart';

class PredictionRepository {
  final PredictionProvider _predictionProvider = new PredictionProvider();

  Future fetchAllPredictionOutletMenu(String id_outlet) => _predictionProvider.fetchAllPredictionOutletMenu(id_outlet);
}