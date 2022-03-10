import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/state/base_provider.dart';

class MyAlbumsBodyState extends BaseProvider {
  final List<AlbumModel> localAlbums;

  MyAlbumsBodyState({required this.localAlbums});
}
