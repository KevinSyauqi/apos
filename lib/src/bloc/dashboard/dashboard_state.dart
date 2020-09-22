import 'package:meta/meta.dart';

@immutable
abstract class DashboardState {}

class InitialDashboardState extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int countOrder;

  DashboardLoaded({this.countOrder});
}
class DashboardLoading extends DashboardState {}
class DashboardFailure extends DashboardState {}
class DashboardEmpty extends DashboardState {}