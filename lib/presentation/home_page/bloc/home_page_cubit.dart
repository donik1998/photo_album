import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/services/templates_service.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';
import 'package:photo_album/presentation/home_page/layouts/home_page_large_layout.dart';
import 'package:photo_album/presentation/home_page/layouts/home_page_mobile_layout.dart';
import 'package:photo_album/presentation/theme/layout_decider.dart';

class HomePageCubit extends Cubit<HomePageState> with LayoutDecider {
  HomePageCubit() : super(HomePageInitial());

  Future<void> loadTemplates(String type) async {
    emit(HomePageLoading());
    final templates = await TemplatesService.instance.getAlbums(type);
    emit(HomePageSuccess(albums: templates));
  }

  @override
  Widget get largeLayout => HomePageLargeLayout();

  @override
  Widget get tabletLayout => HomePageLargeLayout();

  @override
  Widget get mobileLayout => HomePageMobileLayout();
}
