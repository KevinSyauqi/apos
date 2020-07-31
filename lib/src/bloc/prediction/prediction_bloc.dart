import 'dart:async';
import 'package:apos/src/models/predictionModels.dart';
import 'package:apos/src/resources/predictionRepository.dart';
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
    try{
      if(event is GetPredictionOutletMenu){
        yield PredictionLoading();
        List<Prediction> listPrediction;

        listPrediction = await _predictionRepository.fetchAllPredictionOutletMenu("OS2000101");

        if(listPrediction.length == 0){
          yield PredictionEmpty();
        } else {
          yield PredictionLoaded(listPrediction: listPrediction);
        }
      }
    }catch(e){
      print(e);
      yield PredictionError();
    }
  }
}
