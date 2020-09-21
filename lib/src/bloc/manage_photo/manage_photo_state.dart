import 'package:apos/src/models/menuModels.dart';
import 'package:apos/src/models/photoModels.dart';

abstract class PhotoState {}

class PhotoInitialized extends PhotoState {}

class PhotoEmpty extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoError extends PhotoState {}

class PhotoLoaded extends PhotoState {
  List<Photo> photos;
  PhotoLoaded({this.photos});
}

class PhotoAddLoading extends PhotoState {}

class PhotoAddInitialized extends PhotoState {}

class PhotoAddError extends PhotoState {}

class PhotoAddSuccess extends PhotoState {}

class PhotoAddFailed extends PhotoState {
  final String message;
  PhotoAddFailed({this.message});
}

class PhotoUpdateLoading extends PhotoState {}

class PhotoUpdateLoaded extends PhotoState {
  final Photo photo;
  PhotoUpdateLoaded({this.photo});
}

class PhotoUpdateInitialized extends PhotoState {}

class PhotoUpdateError extends PhotoState {}

class PhotoUpdateSuccess extends PhotoState {}

class PhotoUpdateFailed extends PhotoState {
  final String message;
  PhotoUpdateFailed({this.message});
}




