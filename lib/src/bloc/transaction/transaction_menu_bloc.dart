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
    try {
      if (event is FetchMenus) {
        yield TrscMenuLoading();
        List<Menu> menus;
        menus = await _transactionRepository
            .fetchMenus("OS2000201");
        if (menus.length == 0) {
          yield TrscMenuEmpty();
        } else {
          List<Menu> foods = List<Menu>();
          List<Menu> drinks = List<Menu>();

          menus.forEach((menu) {
            if (menu.category == "food") foods.add(menu);
            else drinks.add(menu);
          });

          yield TrscMenuLoaded(foods: foods, drinks: drinks,
              foodMenuCounter: new List(foods.length),
              drinkMenuCounter: new List(drinks.length));
        }
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
