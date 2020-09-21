import 'package:equatable/equatable.dart';
import 'dart:convert';

class Photo {

  String _id_menu;
  String _base64_photo;


  Photo(this._base64_photo);

  String get id_menu => _id_menu;

  String get base64_photo => _base64_photo;


  set base64_photo(String value) {
    _base64_photo = value;
  }

  Photo.fromJson(Map<String, dynamic> json) {
    _id_menu = json["id_menu"];
    _base64_photo = json['base64_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_menu'] = this._id_menu;
    data['base64_photo'] = this._base64_photo;
    return data;
  }
}

class ListPhoto {
  List<Photo> photos;

  ListPhoto(this.photos);

  ListPhoto.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      photos = new List<Photo>();
      json['data'].forEach((v) {
        photos.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
