import 'dart:async';
import 'package:apos/src/models/outletModels.dart';
import 'package:apos/src/resources/outletRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
  final OutletRepository outletRepository = OutletRepository();

  @override
  OutletState get initialState => OutletInitial();

  @override
  Stream<OutletState> mapEventToState(
    OutletEvent event,
  ) async* {
    if(event is FetchingAllOutletStore){
      yield OutletLoading();
      List<Outlet> outlets;
      outlets = await outletRepository.fetchAllOutletStore("S20001");
      if(outlets != 0){
        yield OutletListLoaded(outlets: outlets);
      }
      else yield OutletEmpty();
    }
    if(event is AddOutletForm){
      yield AddOutletLoading();

      Outlet outlet = Outlet("S20001",event.name_outlet, event.address_outlet,event.phone_outlet);
      final response = await outletRepository.addOutlet(outlet);

      final bool success = response['success'];
      if(success){
        yield AddOutletSuccess();
      } else{
        yield AddOutletFailed(message: response['message']);
      }

    }

  }
}
