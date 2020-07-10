import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/historyRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';


class HistoryBloc extends Bloc<HistoryEvent, HistoryState>{
  final HistoryRepository _historyRepository= new HistoryRepository();

  @override
  HistoryState get initialState => HistoryInitial();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async*{
   try{
     if(event is FetchSales){
       yield HistoryLoading();
       List<Sales> listSales;

       listSales = await _historyRepository
          .getAllOutletSales("4069798d529343d59da680b1336d7dd6");
       if (listSales.length == 0) {
         yield HistoryEmpty();
       } else {
         yield HistoryLoaded(listSales: listSales);
       }
     }
   }catch(e){
     print(e);
     yield HistoryFailure();
   }
  }
}

