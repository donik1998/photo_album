import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/widgets/file_picker.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageAddAlbumPageTemplatesBody extends StatefulWidget {
  const HomePageAddAlbumPageTemplatesBody({Key? key}) : super(key: key);

  @override
  State<HomePageAddAlbumPageTemplatesBody> createState() => _HomePageAddAlbumPageTemplatesBodyState();
}

class _HomePageAddAlbumPageTemplatesBodyState extends State<HomePageAddAlbumPageTemplatesBody> {
  List<Map<String, dynamic>> templateCategories = List.empty(growable: true);
  String _currentAlbumPageTemplateType = '';
  bool _isLoading = true;
  bool _isUploading = false;
  TextEditingController _titleController = TextEditingController();
  PlatformFile? _selectedFile;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final templateCategoryDocs = await FirebaseFirestore.instance.collection('album_template_page_types').get();
      setState(() {
        templateCategories = List.from(templateCategoryDocs.docs.map((e) => e.data()));
        _currentAlbumPageTemplateType = templateCategories.first['type'];
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Loader();
    else if (templateCategories.isEmpty)
      return EmptyListWidget();
    else
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomTextField(
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
                  ),
                  AppSpacing.horizontalSpace20,
                  AppSpacing.horizontalSpace20,
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      value: _currentAlbumPageTemplateType,
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: AppColors.darkBlue,
                      elevation: 0,
                      focusColor: AppColors.darkBlue,
                      itemHeight: 48,
                      onChanged: (value) => setState(() => _currentAlbumPageTemplateType = value!),
                      items: templateCategories
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem<String>(
                              value: e['type'],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e['type_mask']['ru'],
                                  style: AppTextStyles.smallTitleBold.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalSpace32,
              FilePickerWidget(
                initialFileLink: _currentAlbumPageTemplateType,
                onFileSelected: (file) => setState(() => _selectedFile = file.first),
              ),
              AppSpacing.verticalSpace32,
              if (_isUploading) Padding(padding: AppInsets.horizontalInsets36, child: LinearProgressIndicator()),
              if (_isUploading) AppSpacing.verticalSpace32,
              CustomButton.text(
                text: 'Сохранить',
                onTap: () async {
                  final bool dataIsValid = _selectedFile != null &&
                      (_formKey.currentState?.validate() ?? false) &&
                      _currentAlbumPageTemplateType.isNotEmpty;
                  if (dataIsValid) {
                    setState(() => _isUploading = true);
                    TaskSnapshot uploadTask = await FirebaseStorage.instance
                        .ref(
                            'template_pages/$_currentAlbumPageTemplateType/${_selectedFile!.name.replaceAll('.', '-')}.${_selectedFile!.extension}')
                        .putData(_selectedFile!.bytes!);
                    String downloadLink = await uploadTask.ref.getDownloadURL();
                    await FirebaseFirestore.instance.collection('album_page_templates').add({
                      'link': downloadLink,
                      'type': _currentAlbumPageTemplateType,
                      'title': _titleController.text,
                    });
                    setState(() {
                      _titleController.clear();
                      _selectedFile = null;
                      _isUploading = false;
                      _currentAlbumPageTemplateType = templateCategories.first['type'];
                    });
                    // final cubit = context.read<HomePageCubit>();
                    // cubit.emit(HomePageSuccess(pageIndex: cubit.state.pageIndex, categoriesList: cubit.state.categoriesList, successMessage: ));
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
      );
  }
}
