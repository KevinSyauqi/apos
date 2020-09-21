import 'package:apos/src/models/menuModels.dart';
import 'package:apos/src/models/photoModels.dart';

class PhotoEvent {}

class FetchingAllPhoto extends PhotoEvent {}

class AddPhotoButtonPressed extends PhotoEvent {}

class AddPhotoButtonFormPressed extends PhotoEvent {
  final String base64_photo;

  AddPhotoButtonFormPressed({this.base64_photo});
}

class UpdatePhotoButton extends PhotoEvent {
  final Photo photo;

  UpdatePhotoButton({this.photo});
}

class UpdatePhotoButtonFormPressed extends PhotoEvent {
  final String id_menu;
  final String base64_photo;

  UpdatePhotoButtonFormPressed({this.id_menu, this.base64_photo});


}

class FetchPhoto extends PhotoEvent {
  final Photo photo;

  FetchPhoto({this.photo});
}

