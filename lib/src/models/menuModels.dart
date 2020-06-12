import 'dart:core';
import 'package:equatable/equatable.dart';

class Menu{
  String _id_outlet_menu;
  String _name_menu;
  String _category;
  String _description;
  String _photo_menu;
  int _cog;
  int _price;
  int _stock;


  Menu(this._name_menu, this._category, this._description,
      this._photo_menu, this._cog, this._price, this._stock);

  String get id_outlet_menu => _id_outlet_menu;

  String get name_menu => _name_menu;

  set name_menu(String value) {
    _name_menu = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get photo_menu => _photo_menu;

  set photo_menu(String value) {
    _photo_menu = value;
  }

  int get cog => _cog;

  set cog(int value) {
    _cog = value;
  }

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  int get stock => _stock;

  set stock(int value) {
    _stock = value;
  }


  Menu.fromJson(Map<String, dynamic> json) {
    _id_outlet_menu = json["id_menu_outlet"];
    _name_menu = json['name_menu'];
    _category = json['category'];
    _description = json['description'];
    _photo_menu = json['photo_menu'];
    _cog = json['cog'];
    _price = json['price'];
    _stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_menu_outlet'] = this._id_outlet_menu;
    data['name_menu'] = this._name_menu;
    data['category'] = this._category;
    data['description'] = this._description;
    data['photo_menu'] = this._description;
    data['cog'] = this._cog;
    data['price'] = this._price;
    data['stock'] = this._stock;
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
