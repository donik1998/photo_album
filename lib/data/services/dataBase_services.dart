import 'package:photo_album/data/local/database.dart';
import 'package:photo_album/data/models/album_template.dart';

class DataBaseService {
  DataBaseService._();

  static DataBaseService instance = DataBaseService._();

  Future<void> saveAlbumToDB(AlbumModel albumModel) async {
    await AppDatabase.instance.insertAlbum(albumModel.databaseModel);
  }

  Future<List<AlbumModel>> getAlbumFromDB() async {
    final localAlbums = await AppDatabase.instance.getAllAlbums();
    return localAlbums.map<AlbumModel>((e) => AlbumModel.fromLocalAlbum(e)).toList();
  }

  Stream<List<AlbumModel>> get localAlbumsStream => AppDatabase.instance.localAlbumStream
      .map<List<AlbumModel>>((event) => List<AlbumModel>.from(event.map<AlbumModel>((e) => AlbumModel.fromLocalAlbum(e))));
}
