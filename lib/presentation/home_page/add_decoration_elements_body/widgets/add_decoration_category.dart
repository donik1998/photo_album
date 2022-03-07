import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AddDecorationCategory extends StatefulWidget {
  const AddDecorationCategory({Key? key}) : super(key: key);

  @override
  State<AddDecorationCategory> createState() => _AddDecorationCategoryState();
}

class _AddDecorationCategoryState extends State<AddDecorationCategory> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.15,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Добавить категорию', style: AppTextStyles.title.copyWith(color: AppColors.white)),
                AppSpacing.verticalSpace24,
                CustomTextField(
                  labelText: 'Название категории',
                  controller: _titleController,
                  validator: (value) {
                    if (value?.isEmpty ?? false)
                      return 'Это обязательное поле';
                    else
                      return null;
                  },
                  onComplete: () => _onSaved(context),
                ),
                AppSpacing.verticalSpace24,
                if (_loading) LinearProgressIndicator(),
                if (!_loading)
                  CustomButton.text(
                    text: 'Сохранить',
                    onTap: () => _onSaved(context),
                    color: AppColors.darkBlue,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSaved(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _loading = true);
      await FirebaseFirestore.instance.collection('decoration_categories').add({
        'type': _titleController.text,
        'type_masks': {'ru': _titleController.text}
      });
      setState(() => _loading = true);
      Navigator.pop(context, 'Успешно добавлено');
    }
  }
}
