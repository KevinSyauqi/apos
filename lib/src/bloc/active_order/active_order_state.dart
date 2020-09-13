import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActiveOrderState {}

class ActiveOrderInitial extends ActiveOrderState {}

class ActiveOrderLoading extends ActiveOrderState {}

class ActiveOrderLoaded extends ActiveOrderState {
  ListOrder listOrder;
  ActiveOrderLoaded({this.listOrder});
}

class ActiveOrderFailure extends ActiveOrderState {}

class ActiveOrderEmpty extends ActiveOrderState{}
