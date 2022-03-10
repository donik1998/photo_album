import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/presentation/state/base_provider.dart';

class MainPageBodyState extends BaseProvider {
  final List<AlbumPageTemplateCategory> templateCategories;
  final List<DecorationCategory> decorationCategories;
  TextEditingController textController = TextEditingController();
  bool searchBarEnabled = false;

  MainPageBodyState({
    required this.templateCategories,
    required this.decorationCategories,
  });

  void toggleSearchBarAvailability() {
    searchBarEnabled = !searchBarEnabled;
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
