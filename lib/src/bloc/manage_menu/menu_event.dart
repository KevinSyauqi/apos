import 'package:apos/src/models/menuModels.dart';

class MenuEvent {}

class FetchingAllMenu extends MenuEvent {}

class AddMenuButtonPressed extends MenuEvent {}

class AddMenuButtonFormPressed extends MenuEvent {
  final String name_menu;
  final String cost;
  final String price;
  final String category;

  AddMenuButtonFormPressed({this.name_menu, this.cost, this.price, this.category});
}

class UpdateMenuButton extends MenuEvent {
  final Menu menu;

  UpdateMenuButton({this.menu});
}

class UpdateMenuButtonFormPressed extends MenuEvent {
  final String name_menu;
  final String cost;
  final String price;
  final String category;

  UpdateMenuButtonFormPressed({this.name_menu, this.cost, this.price, this.category});


}