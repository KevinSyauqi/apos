import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  @override
  ReceiptState get initialState => InitialReceiptState();

  @override
  Stream<ReceiptState> mapEventToState(
    ReceiptEvent event,
  ) async* {
    if(event is getReceipt){
      yield ReceiptLoading();
      yield ReceiptLoaded(sales: event.sales, order: event.order, payment: event.payment, listOrderItem: event.listOrderItem);
    }
  }
}
