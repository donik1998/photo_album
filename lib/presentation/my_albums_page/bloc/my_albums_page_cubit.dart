import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/services/my_album_service.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_state.dart';

class MyAlbumsPageCubit extends Cubit<MyAlbumsPageState> {
  MyAlbumsPageCubit() : super(MyAlbumsPageInitial()) {
    loadMyAlbums();
  }

  Future<void> loadMyAlbums() async {
    emit(MyAlbumsPageLoading());
    final albums = await MyAlbumService.instance.loadLocalAlbums();
    emit(MyAlbumsPageSuccess(albums: albums));
  }
}
