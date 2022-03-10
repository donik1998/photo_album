import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';

abstract class _TemplateService {
  Future<List<AlbumPageTemplateCategory>> getAlbumCategories();
}

class TemplatesService extends _TemplateService {
  TemplatesService._();

  static TemplatesService get instance => TemplatesService._();

  @override
  Future<List<AlbumPageTemplateCategory>> getAlbumCategories() async {
    final albums = await FirebaseFirestore.instance.collection('album_template_page_types').get();
    return albums.docs.map<AlbumPageTemplateCategory>((e) => AlbumPageTemplateCategory.fromJson(e.data())).toList();
  }
}
