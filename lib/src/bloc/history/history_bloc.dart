import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/historyRepository.dart';
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
       ListSales listSales;
       List<String> customers_name = List<String>();
       final response = await _historyRepository.getSalesHistory();

       if (response["success"] == true) {
         listSales = ListSales.fromJson(response);

         if (response['data'] != null) {
           response['data'].forEach((name) {
             if(name['customer_name'] == null){
               customers_name.add('');
             }
             else customers_name.add(name['customer_name']);
           });
         }

         if(listSales.listSales.length == 0){
           yield HistoryEmpty();
         } else yield HistoryLoaded(listSales: listSales.listSales, customers_name: customers_name);
       } else {
         yield HistoryFailure();
       }
     }
     if(event is GetDetailSales){
       yield DetailHistoryLoading();
       final response = await _historyRepository.getDetailSalesHistory(event.id_sale);
       if(response["success"] == true){
         Sales sales = Sales.fromJson(response["data"]["sales"]);
         Order order = Order.fromJson(response["data"]["order"]);
         Payment payment = Payment.fromJson(response["data"]["payment"]);
         response["data"] = response["data"]["listOrderItem"];
         ListOrderItem listOrderItem = ListOrderItem.fromJson(response);

         yield DetailHistoryLoaded(sales: sales, order: order, payment: payment, listOrderItem: listOrderItem.listOrderItem);
       }else{
         yield HistoryFailure();
       }

     }
   }catch(e){
     print(e);
     yield HistoryFailure();
   }
  }
}

