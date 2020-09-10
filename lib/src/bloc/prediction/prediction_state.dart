import 'package:apos/src/models/predictionModels.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PredictionState {}

class PredictionInitialized extends PredictionState {}

class PredictionEmpty extends PredictionState {}

class PredictionError extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionLoaded extends PredictionState {
  final totalSalesPrediction;
  final totalIncomePrediction;
  final totalProfitPrediction;
  final List<Prediction> listPrediction;

  PredictionLoaded({this.totalSalesPrediction, this.totalIncomePrediction,
    this.totalProfitPrediction, this.listPrediction});
}

