import 'package:meta/meta.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {}

class CheckoutFailure extends CheckoutState {}

class CheckoutFinish extends CheckoutState {}