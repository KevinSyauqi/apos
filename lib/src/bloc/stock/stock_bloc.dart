import 'dart:async';
import 'package:apos/src/bloc/manage_stock/manage_stock_event.dart';
import 'package:apos/src/bloc/manage_stock/manage_stock_state.dart';
import 'package:apos/src/bloc/stock/stock_event.dart';
import 'package:apos/src/bloc/stock/stock_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageStockRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final ManageStockRepository _manageStockRepository = ManageStockRepository();

  @override
  StockState get initialState => StockInitialized();

  @override
  Stream<StockState> mapEventToState(StockEvent event) async* {
    try {
      if(event is AddStock){
          if(event.quantity_stock > 0){
            final response = await _manageStockRepository.addStock(event.id_menu, event.quantity_stock);
            if(response["success"] == true){
              yield AddStockSuccess();
            }else yield AddStockFailure();
          }else yield AddStockFailure();
      }
      if(event is RemoveStock){
        if(event.quantity_stock > 0){
          final quantity_stock = -event.quantity_stock;
          final response = await _manageStockRepository.removeStock(event.id_menu, quantity_stock);
          if(response["success"] == true){
            yield RemoveStockSuccess();
          }else yield RemoveStockFailure();
        }else yield RemoveStockFailure();
      }
      if(event is ReloadStock){
        yield StockInitialized();
      }
    }catch(e){
      print(e);
      yield StockError();
    }
  }
}
