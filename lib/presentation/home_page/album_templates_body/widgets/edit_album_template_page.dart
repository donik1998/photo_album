import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/template_page_model.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/home_page/widgets/album_page_template_category_card.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class EditAlbumTemplatePage extends StatefulWidget {
  final AlbumPageTemplate template;
  final List<AlbumPageTemplateCategory> categories;

  const EditAlbumTemplatePage({
    Key? key,
    required this.categories,
    required this.template,
  }) : super(key: key);

  @override
  State<EditAlbumTemplatePage> createState() => _EditAlbumTemplatePageState();
}

class _EditAlbumTemplatePageState extends State<EditAlbumTemplatePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController = TextEditingController(text: widget.template.title);
  AlbumPageTemplateCategory? selectedCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.categories.isNotEmpty) {
      final category = widget.categories.singleWhere(
        (element) => element.type == widget.template.type,
        orElse: () => AlbumPageTemplateCategory(type: '', masks: {}),
      );
      if (category.type.isNotEmpty) selectedCategory = category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          width: 550,
          child: Padding(
            padding: AppInsets.horizontalInsets16,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSpacing.verticalSpace16,
                  Text('Изменить шаблон страницы', style: AppTextStyles.title.copyWith(color: AppColors.white)),
                  AppSpacing.verticalSpace24,
                  CustomTextField(
                    fillColor: AppColors.darkBlue,
                    labelText: 'Название шаблона',
                    controller: _titleController,
                    labelColor: AppColors.white,
                    inputTextColor: AppColors.white,
                    validator: (value) {
                      if (value?.isEmpty ?? false)
                        return 'Это обязательное поле';
                      else
                        return null;
                    },
                  ),
                  AppSpacing.verticalSpace16,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        for (final link in widget.template.imageLinks)
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CachedNetworkImage(
                              width: 196,
                              height: 128,
                              imageUrl: link,
                              imageBuilder: (context, image) => Image(image: image, fit: BoxFit.cover),
                              errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outline, color: Colors.white)),
                            ),
                          ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalSpace16,
                  SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Категория шаблонов', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                        AppSpacing.horizontalSpace16,
                        for (final category in widget.categories)
                          AlbumPageTemplateCategoeyCard(
                            category: category,
                            onTap: () => setState(() => selectedCategory = category),
                            isSelected: selectedCategory == category,
                          ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalSpace16,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CustomButton.text(
                          text: 'Отменить',
                          onTap: () => Navigator.pop(context),
                          color: AppColors.darkBlue,
                        ),
                      ),
                      AppSpacing.horizontalSpace16,
                      if (_isLoading) Padding(padding: AppInsets.horizontalInsets36, child: LinearProgressIndicator()),
                      if (_isLoading) AppSpacing.horizontalSpace16,
                      Expanded(
                        child: CustomButton.text(
                          text: 'Сохранить',
                          onTap: () async {
                            if ((_formKey.currentState?.validate() ?? false) && selectedCategory != null) {
                              setState(() => _isLoading = true);
                              bool templateTypeChanged = widget.template.type != selectedCategory!.type;
                              bool titleWasEdited = _titleController.text != widget.template.title;
                              await FirebaseFirestore.instance.doc('album_page_templates/${widget.template.docId}').update(
                                    widget.template
                                        .copyWith(
                                          type: templateTypeChanged ? selectedCategory!.type : null,
                                          title: titleWasEdited ? _titleController.text : null,
                                        )
                                        .toMap,
                                  );
                              setState(() => _isLoading = false);
                              Navigator.pop(context, 'Изменено успешно');
                            }
                          },
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSpace16,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
