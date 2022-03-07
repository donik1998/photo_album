import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/add_album_page_templates_body/home_page_add_album_page_template_body.dart';
import 'package:photo_album/presentation/home_page/add_decoration_elements_body/home_page_add_content_body.dart';
import 'package:photo_album/presentation/home_page/album_templates_body/album_page_templates_body.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/home_page_decoration_elements_body/home_page_decoration_elements_body.dart';
import 'package:photo_album/presentation/home_page/widgets/home_page_orders_body.dart';
import 'package:photo_album/presentation/home_page/widgets/sidebar.dart';

class HomePageLargeLayout extends StatefulWidget {
  const HomePageLargeLayout({Key? key}) : super(key: key);

  @override
  State<HomePageLargeLayout> createState() => _HomePageLargeLayoutState();
}

class _HomePageLargeLayoutState extends State<HomePageLargeLayout> {
  List<AlbumPageTemplateCategory> templateCategories = List.empty(growable: true);
  List<DecorationCategory> decorationCategories = List.empty();
  List<Widget> homePageBodies = List.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final templateCategoryDocs = await FirebaseFirestore.instance.collection('album_template_page_types').get();
      final categoryDocs = await FirebaseFirestore.instance.collection('decoration_categories').get();
      setState(() {
        templateCategories = List<AlbumPageTemplateCategory>.from(
          templateCategoryDocs.docs.map((e) => AlbumPageTemplateCategory.fromJson(e.data())),
        );
        decorationCategories = List.from(
          categoryDocs.docs.map((e) => DecorationCategory.fromJson(e.data())),
        );
        homePageBodies = [
          HomePageOrdersBody(),
          AlbumPageTemplatesBody(templateCategories: templateCategories),
          HomePageDecorationElementsBody(categories: decorationCategories),
          HomePageAddAlbumPageTemplatesBody(albumPageTemplateCategories: templateCategories),
          HomePageAddContentBody(categories: decorationCategories),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    if (homePageBodies.isEmpty) return Loader();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: SideBar(onPageChanged: (value) => cubit.changeCurrentIndex(value)),
        ),
        Expanded(
          flex: 7,
          child: homePageBodies.elementAt(cubit.currentPageIndex),
        ),
      ],
    );
  }
}
