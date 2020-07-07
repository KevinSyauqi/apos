import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/transactionMenuRepository.dart';
import 'package:apos/src/ui/Transaksi/checkout.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class TransactionMenuBloc extends Bloc<TransactionMenuEvent, TransactionMenuState> {
  final TransactionRepository _transactionRepository = TransactionRepository();

  @override
  TransactionMenuState get initialState => TrscMenuInitialized();

  @override
  Stream<TransactionMenuState> mapEventToState(
    TransactionMenuEvent event,
  ) async* {
    List<Menu> menus;
    List orderCount;
    try {
      if (event is FetchMenus) {
        yield TrscMenuLoading();
        menus = await _transactionRepository
            .fetchMenus("4069798d529343d59da680b1336d7dd6");
        if (menus.length == 0) {
          yield TrscMenuEmpty();
        } else {
          yield TrscMenuLoaded(menus: menus);
        }
      }
      if (event is CheckoutButtonPressed) {
        yield CheckoutInitialized(listOrder: event.listOrder, sales: event.sales);
      }
      if(event is OrderMenuIncrement){
          yield OrderCount();
      }

    }catch(e){
      print(e);
      yield TrscError();
    }
  }
}
