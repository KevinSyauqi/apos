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

      listPegawai = await pegawaiRepository.fetchAllPegawaiOutlet("d586b2862d7645e497e41f3b1ae7a932");
      if(listPegawai != 0){
        yield PegawaiListLoaded(listPegawai: listPegawai);
      }
      else yield PegawaiEmpty();
    }
  }
}



