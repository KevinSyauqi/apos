import 'package:apos/src/models/menuModels.dart';

abstract class MenuState {}

class MenuInitialized extends MenuState {}

class MenuEmpty extends MenuState {}

class MenuLoading extends MenuState {}

class MenuError extends MenuState {}

class MenuLoaded extends MenuState {
  List<Menu> menus;
  MenuLoaded({this.menus});
}


