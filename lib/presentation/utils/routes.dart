import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';

class AppRoutes {
  AppRoutes._();
  static const String ROOT_PAGE = '/';
  static const String LOGIN_PAGE = '/login_page';
  static const String LOGIN_WITH_EMAIL_PAGE = '/login_with_email_page';
  static const String ALL_TEMPLATES_PAGE = '/all_templates_page';
  static const String EDITOR_PAGE = '/editor_page';
}

class AllTemplatesPageArgs {
  final String templateType;

  AllTemplatesPageArgs({required this.templateType});
}

class RedactorPageArgs {
  final Widget? backImage;
  final List<AlbumPageTemplateCategory> albumPageTemplateCategories;
  final List<DecorationCategory> decorationCategories;
  final bool openElementsSheetFirst;

  RedactorPageArgs({
    this.backImage,
    this.openElementsSheetFirst = false,
    required this.albumPageTemplateCategories,
    required this.decorationCategories,
  });

  RedactorPageArgs copyWith({
    Widget? backImage,
    List<AlbumPageTemplateCategory>? albumPageTemplateCategories,
    List<DecorationCategory>? decorationCategories,
  }) =>
      RedactorPageArgs(
        backImage: backImage ?? this.backImage,
        albumPageTemplateCategories: albumPageTemplateCategories ?? this.albumPageTemplateCategories,
        decorationCategories: decorationCategories ?? this.decorationCategories,
      );
}

class PhotoEditorPageArgs {
  final File image;

  PhotoEditorPageArgs({required this.image});
}
