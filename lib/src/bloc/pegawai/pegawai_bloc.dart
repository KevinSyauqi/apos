import 'dart:async';

import 'package:apos/src/models/pegawaiModels.dart';
import 'package:apos/src/resources/pegawaiRepository.dart';
import 'package:bloc/bloc.dart';

import '../bloc.dart';


class PegawaiBloc extends Bloc<PegawaiEvent, PegawaiState> {
  final PegawaiRepository pegawaiRepository = PegawaiRepository();

  @override
  PegawaiState get initialState => PegawaiInitial();

  @override
  Stream<PegawaiState> mapEventToState(
    PegawaiEvent event, 
  ) async* {
    List<Pegawai> listPegawai;

    if(event is FetchingAllPegawaiStore){

      listPegawai = await pegawaiRepository.fetchAllPegawaiStore("57cbc1d67fc145bb93af7546ae36c00a");
      if(listPegawai != 0){
        yield PegawaiListLoaded(listPegawai: listPegawai);
      }
      else yield PegawaiEmpty();
    }
  }
}
