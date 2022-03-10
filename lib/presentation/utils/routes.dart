import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/pages_template_model.dart';

class AppRoutes {
  AppRoutes._();
  static const String ROOT_PAGE = '/';
  static const String LOGIN_PAGE = '/login_page';
  static const String LOGIN_WITH_EMAIL_PAGE = '/login_with_email_page';
  static const String ALL_TEMPLATES_PAGE = '/all_templates_page';
  static const String EDITOR_PAGE = '/editor_page';
}

class AllTemplatesPageArgs {
  final List<AlbumPageTemplate> templates;

  AllTemplatesPageArgs({required this.templates});
}

class RedactorPageArgs {
  final Widget? backImage;
  final List<AlbumPageTemplateCategory> albumPageTemplateCategories;
  final List<DecorationCategory> decorationCategories;

  RedactorPageArgs({
    this.backImage,
    required this.albumPageTemplateCategories,
    required this.decorationCategories,
  });
}
