import 'package:photo_album/data/local/database.dart';
import 'package:photo_album/data/models/album_template.dart';

class DataBaseService {
  final appDataBase = AppDatabase();

  Future<void> saveAlbumToDB(AlbumModel albumModel) async {
    await appDataBase.insertAlbum(albumModel.databaseModel);
  }

  Future<List<AlbumModel>> getAlbumFromDB() async {
    final localAlbums = await appDataBase.getAllAlbums();
    return localAlbums.map<AlbumModel>((e) => AlbumModel.fromLocalAlbum(e)).toList();
  }
}
