import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/data/models/album_template.dart';

abstract class _TemplateService {
  Future<List<AlbumModel>> getAlbums(String type);
}

class TemplatesService extends _TemplateService {
  TemplatesService._();

  static TemplatesService get instance => TemplatesService._();

  @override
  Future<List<AlbumModel>> getAlbums(String type) async {
    final albums = await FirebaseFirestore.instance.collection('templates').where('type', isEqualTo: type).get();
    return albums.docs.map<AlbumModel>((e) => AlbumModel.fromDoc(e)).toList();
  }
}
