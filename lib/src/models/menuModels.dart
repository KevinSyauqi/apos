import 'dart:core';

class Menu{
  String _id_menu;
  String _name_menu;
  String _category;
  int _cost;
  int _price;
  bool _is_active;


  Menu(this._name_menu, this._category, this._cost, this._price);


  String get id_menu => _id_menu;

  String get name_menu => _name_menu;

  String get category => _category;

  int get cost => _cost;

  int get price => _price;

  bool get is_active => _is_active;


  set name_menu(String value) {
    _name_menu = value;
  }

  set category(String value) {
    _category = value;
  }

  set cost(int value) {
    _cost = value;
  }

  set price(int value) {
    _price = value;
  }

  set is_active(bool value) {
    _is_active = value;
  }

  Menu.fromJson(Map<String, dynamic> json) {
    _id_menu = json["id_menu"];
    _name_menu = json['name_menu'];
    _category = json['category'];
    _cost = json['cog'];
    _price = json['price'];
    _is_active = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_outlet_menu'] = this._id_menu;
    data['name_menu'] = this._name_menu;
    data['category'] = this._category;
    data['cost'] = this._cost;
    data['price'] = this._price;
    return data;
  }
}

class ListMenu {
  List<Menu> menus;

  ListMenu(this.menus);

  ListMenu.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      menus = new List<Menu>();
      json['data'].forEach((v) {
        menus.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menus != null) {
      data['menus'] = this.menus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
