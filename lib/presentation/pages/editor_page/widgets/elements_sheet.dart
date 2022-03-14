import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/custom_widgets/templates_widget.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class ElementsSheet extends StatefulWidget {
  final ScrollController controller;
  final List<DecorationCategory> decorationCategories;
  final List<AlbumPageTemplateCategory> albumPageTemplateCategory;

  const ElementsSheet({
    Key? key,
    required this.controller,
    required this.decorationCategories,
    required this.albumPageTemplateCategory,
  }) : super(key: key);

  @override
  _ElementsSheetState createState() => _ElementsSheetState();
}

class _ElementsSheetState extends State<ElementsSheet> {
  DecorationCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.decorationCategories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.horizontalInsets16,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpacing.verticalSpace10,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (final category in widget.decorationCategories)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CustomButton.text(
                      text: category.titleMasks['ru'],
                      onTap: () => setState(() => _selectedCategory = category),
                      textStyle: AppTextStyles.smallTitleBold
                          .copyWith(color: _selectedCategory == category ? AppColors.white : AppColors.black),
                      color: _selectedCategory == category ? AppColors.pinkLight : AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
          AppSpacing.verticalSpace10,
          Divider(),
          if (_selectedCategory?.title == 'Шаблоны')
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (final templateCategory in widget.albumPageTemplateCategory)
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('album_page_templates')
                          .where('type', isEqualTo: templateCategory.value)
                          .get(),
                      builder: (context, templatesSnapshot) {
                        if (templatesSnapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else
                          return TemplatesRowWidget(
                            templates: List<AlbumPageTemplate>.from(
                              templatesSnapshot.data!.docs.map<AlbumPageTemplate>((e) => AlbumPageTemplate.fromJson(e.data())),
                            ),
                            showTopSpacing: true,
                            title: templateCategory.masks['ru'],
                            type: templateCategory.value,
                          );
                      },
                    ),
                ],
              ),
            ),
          if (_selectedCategory?.title == 'Фотографии')
            Expanded(
              child: Center(
                child: CustomButton.text(
                  text: 'Выбрать фото с устройства',
                  onTap: () async {
                    print('picking stuff');
                    final file = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.image,
                    );
                    print('picking stuff ends ');
                    if (file is FilePickerResult) {
                      print('returning stuff');
                      Navigator.pop(
                        context,
                        DecorationElement.local(
                          downloadLink: '',
                          title: file.files.first.name,
                          localPath: file.files.first.path!,
                          height: 150,
                          width: 150,
                          x: MediaQuery.of(context).size.width / 2,
                          y: MediaQuery.of(context).size.height / 2,
                        ),
                      );
                    }
                  },
                  color: AppColors.pinkLight,
                ),
              ),
            ),
          Expanded(
            child: _selectedCategory == null
                ? EmptyListWidget(message: 'Категория элементов не выбрана')
                : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future:
                        FirebaseFirestore.instance.collection('decorations').where('type', isEqualTo: _selectedCategory?.title).get(),
                    builder: (context, decorationsSnapshot) {
                      if (decorationsSnapshot.connectionState == ConnectionState.waiting) {
                        return Loader();
                      } else if (!decorationsSnapshot.hasData) {
                        return Center(child: Text('Тут пусто'));
                      } else {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: decorationsSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final decoration = DecorationElement.fromMap(decorationsSnapshot.data!.docs.elementAt(index).data());
                            return GestureDetector(
                              onTap: () => Navigator.pop(context, decoration),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: decoration.downloadLink,
                                  errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outline)),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
