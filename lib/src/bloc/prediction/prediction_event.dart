import 'package:apos/src/models/predictionModels.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PredictionEvent {}

class GetPredictionOutletMenu extends PredictionEvent {
  final String id_outlet_menu;
  final String startDate;
  final String endDate;

  GetPredictionOutletMenu({this.id_outlet_menu, this.startDate, this.endDate});
}
