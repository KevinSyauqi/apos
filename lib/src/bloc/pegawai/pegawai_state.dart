import 'package:apos/src/models/pegawaiModels.dart';

abstract class PegawaiState {}

class PegawaiInitialized extends PegawaiState {}

class PegawaiEmpty extends PegawaiState {}

class PegawaiLoading extends PegawaiState {}

class PegawaiError extends PegawaiState {}

class PegawaiLoaded extends PegawaiState {
  List<Pegawai> listPegawai;
  PegawaiLoaded({this.listPegawai});
}

class PegawaiAddLoading extends PegawaiState {}

class PegawaiAddInitialized extends PegawaiState {}

class PegawaiAddError extends PegawaiState {}

class PegawaiAddSuccess extends PegawaiState {}

class PegawaiAddFailed extends PegawaiState {
  final String message;
  PegawaiAddFailed({this.message});
}
