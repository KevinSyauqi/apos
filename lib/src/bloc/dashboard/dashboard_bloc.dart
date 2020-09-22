import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageOrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ManageOrderRepository _manageOrderRepository = ManageOrderRepository();

  @override
  DashboardState get initialState => InitialDashboardState();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event,) async* {
    try{
      if (event is FetchDashboard) {
        yield DashboardLoading();
        final response = await _manageOrderRepository.fetchListOrder();
        if (response["success"] == true) {
          List<Order> data = parsedListResponse(response);
          ListOrder listOrder = new ListOrder(data);
          yield DashboardLoaded(countOrder: listOrder.listOrder.length);
        } else{
          yield DashboardFailure();
        }
      }
    }catch(e){
      print(e);
      yield DashboardFailure();
    }
  }

  List<Order> parsedListResponse(final response) {
    if (response["success"] == true) {
      return ListOrder
          .fromJson(response)
          .listOrder;
    } else {
      throw Exception('Failed to load listOrder');
    }
  }
}