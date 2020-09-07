import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/paymentRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentRepository _paymentRepository = new PaymentRepository();

  @override
  PaymentState get initialState => InitialPaymentState();

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if(event is createPayment){
      yield PaymentInProcess();
      Order order = event.order;
      order.id_user = "S001U001";
      final response = await _paymentRepository.createPayment(order);
    }
  }
}
