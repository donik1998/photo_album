import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/state/base_provider.dart';

class MyAlbumsBodyState extends BaseProvider {
  final List<AlbumModel> localAlbums;
  final List<AlbumPageTemplateCategory> templateCategories;
  final List<DecorationCategory> decorationCategories;
  final List<AlbumDecoration> albumBacks;

  MyAlbumsBodyState({
    required this.localAlbums,
    required this.templateCategories,
    required this.decorationCategories,
    required this.albumBacks,
  });
}
