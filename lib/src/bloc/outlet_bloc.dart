import 'dart:async';

import 'package:apos/src/models/outletModels.dart';
import 'package:apos/src/resources/outletRepository.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
  final OutletRepository outletRepository = OutletRepository();

  @override
  OutletState get initialState => OutletInitial();

  @override
  Stream<OutletState> mapEventToState(
    OutletEvent event,
  ) async* {
    List<Outlet> outlets;

    if(event is FetchingAllOutletStore){

      outlets = await outletRepository.fetchAllOutletStore("57cbc1d67fc145bb93af7546ae36c00a");
      if(outlets != 0){
        yield OutletListLoaded(outlets: outlets);
      }
      else yield OutletEmpty();
    }
  }
}
