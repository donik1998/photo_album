import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/home_page/widgets/album_page_template_category_card.dart';
import 'package:photo_album/presentation/home_page/widgets/file_picker.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageAddAlbumPageTemplatesBody extends StatefulWidget {
  final List<AlbumPageTemplateCategory> albumPageTemplateCategories;

  const HomePageAddAlbumPageTemplatesBody({Key? key, required this.albumPageTemplateCategories}) : super(key: key);

  @override
  State<HomePageAddAlbumPageTemplatesBody> createState() => _HomePageAddAlbumPageTemplatesBodyState();
}

class _HomePageAddAlbumPageTemplatesBodyState extends State<HomePageAddAlbumPageTemplatesBody> {
  AlbumPageTemplateCategory? _currentAlbumPageTemplateType;
  bool _isUploading = false;
  TextEditingController _titleController = TextEditingController();
  List<PlatformFile> _selectedFiles = List.empty(growable: true);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.albumPageTemplateCategories.isEmpty)
      return EmptyListWidget();
    else
      return ListView(padding: const EdgeInsets.all(16.0), children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                labelText: 'Название шаблона',
                labelColor: AppColors.white,
                controller: _titleController,
                fillColor: AppColors.darkBlue,
                inputTextColor: AppColors.white,
                validator: (value) {
                  if (value?.isEmpty ?? false)
                    return 'Это обязательное поле';
                  else
                    return null;
                },
              ),
              AppSpacing.verticalSpace24,
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Text('Тип шаблонов страниц', style: AppTextStyles.smallTitleBold.copyWith(color: Colors.white)),
                  AppSpacing.horizontalSpace20,
                  for (final template in widget.albumPageTemplateCategories)
                    AlbumPageTemplateCategoeyCard(
                      category: template,
                      onTap: () => setState(() => _currentAlbumPageTemplateType = template),
                      isSelected: _currentAlbumPageTemplateType == template,
                    ),
                ],
              ),
              AppSpacing.verticalSpace32,
              Text('Файлы', style: AppTextStyles.title.copyWith(color: AppColors.white)),
              AppSpacing.verticalSpace24,
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  if (_selectedFiles.length >= 1)
                    for (final selectedFile in _selectedFiles)
                      FilePickerWidget(
                        width: 196,
                        height: 196,
                        initialWidget: Image.memory(selectedFile.bytes!),
                        onFileSelected: (files) => setState(() => _selectedFiles.addAll(files)),
                      ),
                  FilePickerWidget(
                    width: 196,
                    height: 196,
                    allowMultipleChoice: true,
                    initialWidget: Icon(Icons.add, size: 36, color: AppColors.white),
                    onFileSelected: (files) => setState(() => _selectedFiles.addAll(files)),
                  ),
                ],
              ),
              AppSpacing.verticalSpace32,
              if (_isUploading) Padding(padding: AppInsets.horizontalInsets36, child: LinearProgressIndicator()),
              if (_isUploading) AppSpacing.verticalSpace32,
              CustomButton.text(
                text: 'Сохранить',
                onTap: () async {
                  final dataIsValid = _selectedFiles.isNotEmpty &&
                      (_formKey.currentState?.validate() ?? false) &&
                      _currentAlbumPageTemplateType != null;
                  if (dataIsValid) {
                    setState(() => _isUploading = true);
                    final docRef = await FirebaseFirestore.instance.collection('album_page_templates').add({
                      'type': _currentAlbumPageTemplateType!.type,
                      'title': _titleController.text,
                    });
                    if (_selectedFiles.length == 1) {
                      await _uploadFile(_selectedFiles.first, docRef.id);
                    } else {
                      for (final file in _selectedFiles) await _uploadFile(file, docRef.id);
                    }
                    setState(() {
                      _titleController.clear();
                      _selectedFiles = List.empty(growable: true);
                      _isUploading = false;
                      _currentAlbumPageTemplateType = widget.albumPageTemplateCategories.first;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Успешно добавлено',
                          style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
                        ),
                      ),
                    );
                  }
                },
                color: AppColors.darkBlue,
              ),
            ],
          ),
        ),
      ]);
  }

  Future<void> _uploadFile(PlatformFile file, String collectionDocId) async {
    TaskSnapshot uploadTask = await FirebaseStorage.instance
        .ref('template_pages/${_currentAlbumPageTemplateType!.type}/${file.name.replaceAll('.', '-')}.${file.extension}')
        .putData(file.bytes!);
    String downloadLink = await uploadTask.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection('album_page_templates').doc(collectionDocId).update({
      'links': FieldValue.arrayUnion([downloadLink]),
    });
  }
}
