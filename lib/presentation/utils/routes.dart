import 'dart:io';

import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';

class AppRoutes {
  AppRoutes._();
  static const String ROOT_PAGE = '/';
  static const String LOGIN_PAGE = '/login_page';
  static const String LOGIN_WITH_EMAIL_PAGE = '/login_with_email_page';
  static const String ALL_TEMPLATES_PAGE = '/all_templates_page';
  static const String EDITOR_PAGE = '/editor_page';
  static const String ALL_LOCAL_ALBUMS = '/all_local_albums';
}

class AllTemplatesPageArgs {
  final String templateType;

  AllTemplatesPageArgs({required this.templateType});
}

class RedactorPageArgs {
  final AlbumPageBackground? backImage;
  final List<AlbumPageTemplateCategory> albumPageTemplateCategories;
  final List<DecorationCategory> decorationCategories;
  final bool openElementsSheetFirst;
  final AlbumModel? localAlbum;
  final List<AlbumDecoration> albumBacks;

  RedactorPageArgs({
    this.backImage,
    this.openElementsSheetFirst = false,
    required this.albumPageTemplateCategories,
    required this.decorationCategories,
    this.localAlbum,
    required this.albumBacks,
  });
}

class PhotoEditorPageArgs {
  final File image;

  PhotoEditorPageArgs({required this.image});
}
