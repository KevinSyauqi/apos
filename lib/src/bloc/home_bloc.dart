import 'dart:async';
import 'package:apos/src/ui/Transaksi/transaksi_menu.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  @override
  HomeState get initialState => HomeDashboardPage();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is HomeTransactionPageLoad){
      yield HomeTransactionPage();
    }
    if(event is HomeMenuPageLoad){
      yield HomeMenuPage();
    }
    if(event is HomeOutletPageLoad){
      yield HomeOutletPage();
    }
    if(event is HomeReportPageLoad){
      yield HomeReportPage();
    }
    if(event is HomeEmployeePageLoad){
      yield HomeEmployeePage();
    }
  }
}
