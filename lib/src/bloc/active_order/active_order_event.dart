import 'package:meta/meta.dart';

@immutable
abstract class ActiveOrderEvent {}

class fetchListOrder extends ActiveOrderEvent {}


