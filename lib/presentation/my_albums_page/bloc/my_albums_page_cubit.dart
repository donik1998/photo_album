import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_state.dart';

class MyAlbumsPageCubit extends Cubit<MyAlbumsPageState> {
  MyAlbumsPageCubit() : super(MyAlbumsPageInitial());
}
