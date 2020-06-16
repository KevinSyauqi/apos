import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/registerRepository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository = RegisterRepository();

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is RegisterButtonPressed){
      yield RegisterInProcess();
      final user = User(event.name,event.email,event.username,event.password,event.phone,"");

      if(user != null){
        final response = await _registerRepository.registerUser(user);
        final bool success = response['success'];
        print(success);
        if(success){
          yield RegisterSuccess();
        } else{
          yield RegisterFailed(message: response['message']);
        }
      }
    }
  }
}
