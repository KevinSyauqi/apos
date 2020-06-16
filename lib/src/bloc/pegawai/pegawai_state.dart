import 'package:apos/src/models/pegawaiModels.dart';
import 'package:equatable/equatable.dart';

abstract class PegawaiState extends Equatable {
  const PegawaiState();

  @override
  List<Object> get props => [];
}

class PegawaiInitial extends PegawaiState {}

class PegawaiLoading extends PegawaiState {}

class PegawaiLoaded extends PegawaiState {
  final Pegawai pegawai;
  PegawaiLoaded({this.pegawai});
}

class PegawaiListLoaded extends PegawaiState{
  final List<Pegawai> listPegawai;
  PegawaiListLoaded({this.listPegawai});
}

class PegawaiFailure extends PegawaiState {}

class PegawaiEmpty extends PegawaiState {}

