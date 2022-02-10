import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/services/templates_service.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());


  Future<void> loadTemplates(String type) async {
    emit(HomePageLoading());
    final templates = await TemplatesService.instance.getAlbums(type);
    emit(HomePageSuccess(albums: templates));
  }



}
