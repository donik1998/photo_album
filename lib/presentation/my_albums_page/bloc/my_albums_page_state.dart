abstract class MyAlbumsPageState {}

class MyAlbumsPageInitial extends MyAlbumsPageState {}

class MyAlbumsPageLoading extends MyAlbumsPageState {}

class MyAlbumsPageSuccess extends MyAlbumsPageState {}

class MyAlbumsPageError extends MyAlbumsPageState {
  final String error;

  MyAlbumsPageError({required this.error});
}
