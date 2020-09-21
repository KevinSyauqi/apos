import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/photoModels.dart';
import 'package:apos/src/provider/manageMenuProvider.dart';

class ManagePhotoRepository{
  final ManageMenuProvider menuProvider = new ManageMenuProvider();

  Future<List<Photo>> fetchAllPhoto() async{
    return await menuProvider.fetchAllPhoto();
  }
}