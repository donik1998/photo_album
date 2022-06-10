import 'package:photo_album/data/local/database.dart';
import 'package:photo_album/data/models/album_model.dart';

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

  Future<void> saveDecorationElement(DecorationElement element) async {}

  Future<void> editAlbum(AlbumModel album) async {
    await AppDatabase.instance.editAlbum(album.databaseModel);
  }

  Future<void> deleteAlbum(AlbumModel album) async {
    await AppDatabase.instance.deleteAlbum(album.databaseModel);
  }

  // Future<bool> isSaved(String downloadLink) async {
  //   return await AppDatabase.instance.hasDecorationElementWithLink(downloadLink);
  // }
}
