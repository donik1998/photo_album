import 'package:photo_album/data/models/album_template.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}
class HomePageLoading extends HomePageState {}
class HomePageSuccess extends HomePageState {
  final List<Album> albums;

  HomePageSuccess({required this.albums});
}
class HomePageError extends HomePageState {
  final String error;

  HomePageError({required this.error});
}