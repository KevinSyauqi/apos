import 'package:apos/src/models/predictionModels.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PredictionEvent {}

class GetPredictionSummary extends PredictionEvent{}

class GetDetailPrediction extends PredictionEvent{}

class GetDetailStockPrediction extends PredictionEvent{
  String id_menu;

  GetDetailStockPrediction({this.id_menu});
}