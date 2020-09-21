import 'package:apos/src/models/menuModels.dart';
import 'package:apos/src/models/photoModels.dart';

abstract class MenuState {}

class MenuInitialized extends MenuState {}

class MenuEmpty extends MenuState {}

class MenuLoading extends MenuState {}

class MenuError extends MenuState {}

class MenuLoaded extends MenuState {
  List<Menu> foods;
  List<Menu> drinks;
  List<Menu> noActiveMenus;
  MenuLoaded({this.foods, this.drinks,this.noActiveMenus});
}

class MenuAddLoading extends MenuState {}

class MenuAddInitialized extends MenuState {}

class MenuAddError extends MenuState {}

class MenuAddSuccess extends MenuState {}

class MenuAddFailed extends MenuState {
  final String message;
  MenuAddFailed({this.message});
}

class MenuUpdateLoading extends MenuState {}

class MenuUpdateLoaded extends MenuState {
  final Menu menu;
  final Photo photo;
  MenuUpdateLoaded({this.menu, this.photo});
}

class MenuUpdateInitialized extends MenuState {}

class MenuUpdateError extends MenuState {}

class MenuUpdateSuccess extends MenuState {}

class MenuUpdateFailed extends MenuState {
  final String message;
  MenuUpdateFailed({this.message});
}

class DeactiveMenuSuccess extends MenuState{}
class ActiveMenuSuccess extends MenuState{}



