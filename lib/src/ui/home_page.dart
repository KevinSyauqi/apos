import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/ManageMenu//manage_menu_page.dart';
import 'package:apos/src/ui/ManageStock/manage_stock.dart';
import 'package:apos/src/ui/Report/report_page.dart';
import 'package:apos/src/ui/History//riwayat_transaksi.dart';
import 'package:apos/src/ui/dashboard_page.dart';
import 'package:apos/src/ui/ManageOrder//manage_order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Prediction/prediction_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context, state){
        if(state is HomeManageOrderPage){
          return ManageOrderPage();
        }
        if(state is HomeManageMenuPage){
          return ManageMenuPage();
        }
        if(state is HomeManageStockPage){
          return ManageStockPage();
        }
        if(state is HomeReportPage){
          return ReportPage();
        }
        if(state is HomeHistoryPage){
          return HistoryPage();
        }
        if(state is HomeDashboardPage){
          return DashboardPage();
        }
        if(state is HomePredictionPage){
          return PredictionPage();
        }
        return Container(
            color: Colors.white);
      }
    );
  }
}



