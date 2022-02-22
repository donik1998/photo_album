import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/services/dataBase_services.dart';

abstract class _PersonalAlbumsRepository {
  Future<List<AlbumModel>> loadLocalAlbums();
}

class MyAlbumService extends _PersonalAlbumsRepository {
  MyAlbumService._();

  static MyAlbumService get instance => MyAlbumService._();

  @override
  Future<List<AlbumModel>> loadLocalAlbums() async {
    final albums = await DataBaseService.instance.getAlbumFromDB();
    return albums;
  }
}
