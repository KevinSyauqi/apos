import 'dart:core';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  String id_outlet_menu;
  String name_menu;
  String category;
  String description;
  String photo_menu;
  int cog;
  int price;
  int stock;

  Menu(
      {this.id_outlet_menu,
      this.name_menu,
      this.category,
      this.description,
      this.photo_menu,
      this.cog,
      this.price,
      this.stock});

  Menu.fromJson(Map<String, dynamic> json) {
    id_outlet_menu = json["id_menu_outlet"];
    name_menu = json['name_menu'];
    category = json['category'];
    description = json['description'];
    photo_menu = json['photo_menu'];
    cog = json['cog'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_menu_outlet'] = this.id_outlet_menu;
    data['name_menu'] = this.name_menu;
    data['category'] = this.category;
    data['description'] = this.description;
    data['photo_menu'] = this.description;
    data['cog'] = this.cog;
    data['price'] = this.price;
    data['stock'] = this.stock;
  }

  @override
  List<Object> get props => [id_outlet_menu];

//  List<Menu> fromListJson(Map<String, dynamic> json){
//    List<Menu> data = new List<Menu>();
//    json['data'].forEach((v) {
//      data.add(new Menu.fromJson(v));
//    });
//
//    return data;
//  }
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
