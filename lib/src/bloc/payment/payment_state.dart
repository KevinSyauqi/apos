import 'package:meta/meta.dart';

@immutable
abstract class PaymentState {}

class InitialPaymentState extends PaymentState {}

class PaymentInProcess extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentFailure extends PaymentState {}
