import 'package:apos/src/provider/predictionProvider.dart';

class PredictionRepository {
  final PredictionProvider _predictionProvider = new PredictionProvider();

  Future getPredictionSummery() => _predictionProvider.getPredictionSummary();

  Future getDetailPrediction() => _predictionProvider.getDetailPrediction();

  Future getDetailStockPrediction(String id_menu) => _predictionProvider.getDetailStockPrediction(id_menu);
}