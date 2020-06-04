import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  UserState([List props = const []]);
}

//class GetUserLoading extends UserState {
//  @override
//  String toString() => 'GetUserLoading';
//}