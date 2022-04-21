import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/home_page/add_decoration_elements_body/widgets/decoration_category_card.dart';
import 'package:photo_album/presentation/home_page/widgets/file_picker.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class DecorationElementEditorDialog extends StatefulWidget {
  final DecorationElement element;
  final List<DecorationCategory> categories;

  const DecorationElementEditorDialog({Key? key, required this.element, required this.categories}) : super(key: key);

  @override
  State<DecorationElementEditorDialog> createState() => _DecorationElementEditorDialogState();
}

class _DecorationElementEditorDialogState extends State<DecorationElementEditorDialog> {
  late TextEditingController _titleController = TextEditingController(text: widget.element.title);
  late TextEditingController _widthController = TextEditingController(text: widget.element.width.toInt().toString());
  late TextEditingController _heightController = TextEditingController(text: widget.element.height.toInt().toString());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DecorationCategory? _chosenElementType;
  PlatformFile? _selectedFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _chosenElementType = widget.categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.lightBlue,
      child: Container(
        padding: AppInsets.all16,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Изменить элемент декорации',
                style: AppTextStyles.title.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalSpace16,
              CustomTextField(
                labelText: 'Название элемента',
                fillColor: AppColors.darkBlue,
                labelColor: AppColors.white,
                inputTextColor: AppColors.white,
                controller: _titleController,
              ),
              AppSpacing.verticalSpace16,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Ширина элемента',
                      controller: _widthController,
                      fillColor: AppColors.darkBlue,
                      labelColor: AppColors.white,
                      inputTextColor: AppColors.white,
                      validator: (value) {
                        if (value?.isEmpty ?? false)
                          return 'Это обязательное поле';
                        else if (double.tryParse(value ?? '') == null)
                          return 'Это поле может принимать только числовые значения';
                        else
                          return null;
                      },
                    ),
                  ),
                  AppSpacing.horizontalSpace20,
                  AppSpacing.horizontalSpace20,
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Высота элемента',
                      controller: _heightController,
                      fillColor: AppColors.darkBlue,
                      labelColor: AppColors.white,
                      inputTextColor: AppColors.white,
                      validator: (value) {
                        if (value?.isEmpty ?? false)
                          return 'Это обязательное поле';
                        else if (double.tryParse(value ?? '') == null)
                          return 'Это поле может принимать только числовые значения';
                        else
                          return null;
                      },
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalSpace16,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Тип элемента', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                  AppSpacing.horizontalSpace20,
                  for (final category in widget.categories)
                    DecorationCategoryCard(
                      category: category,
                      onTap: () => setState(() => _chosenElementType = category),
                      isSelected: _chosenElementType == category,
                    ),
                ],
              ),
              AppSpacing.verticalSpace16,
              FilePickerWidget(
                height: 196,
                initialWidget: CachedNetworkImage(imageUrl: widget.element.downloadLink),
                onFileSelected: (file) => setState(() {
                  _selectedFile = file.first;
                }),
              ),
              AppSpacing.verticalSpace16,
              AppSpacing.verticalSpace16,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: CustomButton.text(text: 'Отмена', onTap: () => Navigator.pop(context), color: AppColors.darkBlue)),
                  AppSpacing.horizontalSpace20,
                  AppSpacing.horizontalSpace20,
                  Expanded(
                    child: CustomButton.child(
                      child: _isLoading
                          ? Padding(padding: AppInsets.horizontalInsets36, child: LinearProgressIndicator())
                          : Text(
                              'Сохранить',
                              style: AppTextStyles.bodyTextStyle.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
                            ),
                      onTap: () {
                        setState(() => _isLoading = !_isLoading);
                        if (_formKey.currentState?.validate() ?? false) {
                          if (_selectedFile != null) {
                            FirebaseStorage.instance.refFromURL(widget.element.downloadLink).delete().then((value) async {
                              TaskSnapshot uploadTask = await FirebaseStorage.instance
                                  .ref('$_chosenElementType/${_selectedFile!.name.replaceAll('.', '-')}.${_selectedFile!.extension}')
                                  .putData(_selectedFile!.bytes!);
                              String downloadLink = await uploadTask.ref.getDownloadURL();
                              _updateFirestoreData(context: context, downloadLink: downloadLink);
                            });
                          } else {
                            _updateFirestoreData(context: context);
                          }
                        }
                      },
                      color: AppColors.darkBlue,
                      textStyle: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateFirestoreData({String? downloadLink, required BuildContext context}) => FirebaseFirestore.instance
          .collection('decorations')
          .doc(widget.element.docId)
          .update(widget.element
              .copyWith(
                  width: double.tryParse(_widthController.text) ?? 0,
                  height: double.tryParse(_heightController.text) ?? 0,
                  title: _titleController.text,
                  downloadLink: downloadLink)
              .toMap)
          .then((value) {
        Navigator.pop(context, 'Контент изменен');
      });
}
