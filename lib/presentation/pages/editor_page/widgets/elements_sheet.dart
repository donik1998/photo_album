import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  CrossFadeState _sheetFadeState = CrossFadeState.showFirst;
  AlbumPageTemplate? _selectedTemplate;
  List<String> fonts = ['Oswald', 'Roboto', 'Sans serif'];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.decorationCategories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.horizontalInsets16,
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        crossFadeState: _sheetFadeState,
        firstChild: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppSpacing.verticalSpace4,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.black.withOpacity(0.5),
                ),
                width: 96,
                height: 8,
              ),
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
              if (_selectedCategory?.title == 'Шаблоны') ...[
                for (final templateCategory in widget.albumPageTemplateCategory)
                  FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('album_page_templates')
                        .where('type', isEqualTo: templateCategory.value)
                        .limit(5)
                        .get(),
                    builder: (context, templatesSnapshot) {
                      if (templatesSnapshot.connectionState == ConnectionState.waiting)
                        return Container();
                      else
                        return TemplatesRowWidget(
                          templates: List<AlbumPageTemplate>.from(
                            templatesSnapshot.data!.docs.map<AlbumPageTemplate>((e) => AlbumPageTemplate.fromJson(e.data())),
                          ),
                          showTopSpacing: false,
                          title: templateCategory.masks['ru'],
                          type: templateCategory.value,
                          onTemplateChosen: (template) {
                            setState(() {
                              _sheetFadeState = CrossFadeState.showSecond;
                              _selectedTemplate = template;
                            });
                          },
                        );
                    },
                  ),
              ],
              if (_selectedCategory?.title == 'Фотографии') ...[
                CustomButton.text(
                  text: 'Сделать фото',
                  onTap: () async {
                    final file = await ImagePicker().pickImage(source: ImageSource.camera);
                    if (file is XFile) {
                      final image = await decodeImageFromList(await file.readAsBytes());
                      double suitableWidth = 0;
                      double suitableHeight = 0;
                      if (image.height * 0.25 > MediaQuery.of(context).size.height) {
                        suitableHeight = image.height * 0.125;
                      } else {
                        suitableHeight = image.height * 0.25;
                      }
                      if (image.width * 0.25 > MediaQuery.of(context).size.width) {
                        suitableWidth = image.width * 0.125;
                      } else {
                        suitableWidth = image.width * 0.25;
                      }
                      Navigator.pop(
                        context,
                        DecorationElement.local(
                          downloadLink: '',
                          title: file.name,
                          localPath: file.path,
                          width: suitableWidth,
                          height: suitableHeight,
                          x: MediaQuery.of(context).size.width / 2,
                          y: MediaQuery.of(context).size.height / 2,
                        ),
                      );
                    }
                  },
                  color: AppColors.pinkLight,
                ),
                AppSpacing.verticalSpace16,
                CustomButton.text(
                  text: 'Выбрать фото из устройства',
                  onTap: () async {
                    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (file is XFile) {
                      final image = await decodeImageFromList(await file.readAsBytes());
                      double suitableWidth = 0;
                      double suitableHeight = 0;
                      if (image.height * 0.25 > MediaQuery.of(context).size.height) {
                        suitableHeight = image.height * 0.125;
                      } else {
                        suitableHeight = image.height * 0.25;
                      }
                      if (image.width * 0.25 > MediaQuery.of(context).size.width) {
                        suitableWidth = image.width * 0.125;
                      } else {
                        suitableWidth = image.width * 0.25;
                      }
                      Navigator.pop(
                        context,
                        DecorationElement.local(
                          downloadLink: '',
                          title: file.name,
                          localPath: file.path,
                          width: suitableWidth,
                          height: suitableHeight,
                          x: 0,
                          y: 0,
                        ),
                      );
                    }
                  },
                  color: AppColors.pinkLight,
                ),
              ],
              if (_selectedCategory?.title == 'Текст') ...[
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 110 / 110,
                    ),
                    itemCount: fonts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Sample',
                            style: TextStyle(fontFamily: fonts.elementAt(index), fontSize: 14),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (_onlineContentNeeded)
                Expanded(
                  child: _selectedCategory == null
                      ? EmptyListWidget(message: 'Категория элементов не выбрана')
                      : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('decorations')
                              .where('type', isEqualTo: _selectedCategory?.title)
                              .get(),
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
                                addAutomaticKeepAlives: true,
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
                                      child: Image.network(
                                        decoration.downloadLink,
                                        errorBuilder: (context, url, trace) => Center(child: Icon(Icons.error_outline)),
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
        ),
        secondChild: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppSpacing.verticalSpace16,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      _sheetFadeState = CrossFadeState.showFirst;
                    }),
                    icon: Icon(Icons.arrow_back),
                  ),
                  AppSpacing.horizontalSpace20,
                  Text(_selectedTemplate?.title ?? '', style: AppTextStyles.title),
                ],
              ),
              AppSpacing.verticalSpace16,
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: _selectedTemplate?.downloadLinks.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pop(context, _selectedTemplate?.downloadLinks.elementAt(index) ?? '');
                    },
                    child: CachedNetworkImage(
                      imageUrl: _selectedTemplate?.downloadLinks.elementAt(index) ?? '',
                      width: 110,
                      height: 110,
                      errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outlined)),
                      progressIndicatorBuilder: (context, url, progress) => Loader(),
                      imageBuilder: (context, image) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(image: image),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _onlineContentNeeded =>
      _selectedCategory?.title != 'Шаблоны' && _selectedCategory?.title != 'Фотографии' && _selectedCategory?.title != 'Текст';
}
