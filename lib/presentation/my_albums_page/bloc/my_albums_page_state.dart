import 'package:photo_album/data/models/album_template.dart';

abstract class MyAlbumsPageState {}

class MyAlbumsPageInitial extends MyAlbumsPageState {}

class MyAlbumsPageLoading extends MyAlbumsPageState {}

class MyAlbumsPageSuccess extends MyAlbumsPageState {
  final List<AlbumModel> albums;

  MyAlbumsPageSuccess({required this.albums});
}

class MyAlbumsPageError extends MyAlbumsPageState {
  final String error;

  MyAlbumsPageError({required this.error});
}
