import 'package:photo_album/data/local/database.dart';
import 'package:photo_album/data/models/album_template.dart';

class DataBaseService {
  DataBaseService._();

  static DataBaseService get instance => DataBaseService._();

  Future<void> saveAlbumToDB(AlbumModel albumModel) async {
    await AppDatabase.instance.insertAlbum(albumModel.databaseModel);
  }

  Future<List<AlbumModel>> getAlbumFromDB() async {
    final localAlbums = await AppDatabase.instance.getAllAlbums();
    return localAlbums.map<AlbumModel>((e) => AlbumModel.fromLocalAlbum(e)).toList();
  }
}
