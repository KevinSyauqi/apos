import 'dart:async';
import 'package:apos/src/models/predictionModels.dart';
import 'package:apos/src/repository/predictionRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  PredictionRepository _predictionRepository = PredictionRepository();

  @override
  PredictionState get initialState => PredictionInitialized();

  @override
  Stream<PredictionState> mapEventToState(
    PredictionEvent event,
  ) async* {
    try {
      if (event is GetPredictionSummary) {
        yield PredictionLoading();
        final response = await _predictionRepository.getPredictionSummery();
        if (response["success"] == true) {
          if(response["data"] != null && response["data"] != ""){
            final totalSalesPrediction = response["data"]["predictionSales"][0]["sales"];
            final totalIncomePrediction = response["data"]["predictionIncome"][0]["income"];
            final totalProfitPrediction = response["data"]["predictionProfit"][0]["profit"];
            List<Prediction> listPrediction =
            _parsedFromJson(response["data"], "listPredictionSales");
            yield PredictionLoaded(
                totalSalesPrediction: totalSalesPrediction,
                totalIncomePrediction: totalIncomePrediction,
                totalProfitPrediction: totalProfitPrediction,
                listPrediction: listPrediction);
          }else yield PredictionLoaded(totalSalesPrediction: 0, totalIncomePrediction: 0, totalProfitPrediction: 0, listPrediction: []);
        } else{
          yield PredictionError();
        }
      }
      if(event is GetDetailPrediction){
        yield PredictionDetailLoading();
        final response = await _predictionRepository.getDetailPrediction();
        if(response["success"] == true){
          List<Prediction> listPrediction = _parsedFromJson(response, 'data');
          yield PredictionDetailLoaded(listPrediction: listPrediction);
        } else yield PredictionDetailFailure();
      }
      if(event is GetDetailStockPrediction){
        yield PredictionDetailLoading();
        final response = await _predictionRepository.getDetailStockPrediction(event.id_menu);
        if(response["success"] == true){
          List<Prediction> listPrediction = _parsedFromJson(response, 'data');
          yield PredictionDetailLoaded(listPrediction: listPrediction);
        } else yield PredictionDetailFailure();
      }
    } catch (e) {
      print(e);
      yield PredictionError();
    }
  }

  List<Prediction> _parsedFromJson(Map<String, dynamic> json, String child) {
    List<Prediction> listPrediction = new List<Prediction>();
    if (json['$child'] != null) {
      json['$child'].forEach((v) {
        listPrediction.add(new Prediction.fromJson(v));
      });
    }
    return listPrediction;
  }
}
