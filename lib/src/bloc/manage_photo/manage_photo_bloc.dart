import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/bloc/manage_photo/manage_photo_event.dart';
import 'package:apos/src/bloc/manage_photo/manage_photo_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/photoModels.dart';
import 'package:apos/src/repository/manageMenuRepository.dart';
import 'package:apos/src/repository/managePhotoRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final ManagePhotoRepository _photoRepository = ManagePhotoRepository();

  @override
  PhotoState get initialState => PhotoInitialized();

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    List<Photo> photos;
    try {
      if (event is FetchingAllPhoto) {
        yield PhotoLoading();
        photos = await _photoRepository.fetchAllPhoto();
        if (photos.length == 0) {
          yield PhotoEmpty();
        } else {
          List<Photo> photos = List();

          photos.forEach((photo) {
            photos.add(photo);
          });

          yield PhotoLoaded(photos:photos);
        }
      }
      if (event is AddMenuButtonPressed) {
        yield PhotoAddInitialized();
      }
    } catch (e) {
      print(e);
      yield PhotoError();
    }
  }
}
