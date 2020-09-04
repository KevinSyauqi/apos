class MenuEvent {}

class FetchingAllMenu extends MenuEvent {}

class AddMenuButtonPressed extends MenuEvent {}

class AddMenuButtonFormPressed extends MenuEvent {
  final String name_menu;
  final String cog;
  final String price;
  final bool is_stock;
  final String stock;
  final String description;
  final String category;
  final String imgBase64;

  AddMenuButtonFormPressed({this.name_menu, this.cog, this.price,
    this.is_stock, this.description, this.category, this.stock, this.imgBase64});


}