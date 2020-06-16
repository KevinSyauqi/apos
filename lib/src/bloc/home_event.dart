import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class HomeTransactionPageLoad extends HomeEvent{}

class HomeMenuPageLoad extends HomeEvent{}

class HomeEmployeePageLoad extends HomeEvent{}

class HomeOutletPageLoad extends HomeEvent{}

class HomeReportPageLoad extends HomeEvent{}