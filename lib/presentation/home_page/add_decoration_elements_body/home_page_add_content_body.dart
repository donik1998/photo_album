import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/add_decoration_elements_body/widgets/add_decoration_category.dart';
import 'package:photo_album/presentation/home_page/add_decoration_elements_body/widgets/decoration_category_card.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/widgets/file_picker.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageAddContentBody extends StatefulWidget {
  final List<DecorationCategory> categories;

  const HomePageAddContentBody({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<HomePageAddContentBody> createState() => _HomePageAddContentBodyState();
}

class _HomePageAddContentBodyState extends State<HomePageAddContentBody> {
  DecorationCategory? selectedCategory;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    if (_loading)
      return Loader();
    else if (widget.categories.isEmpty)
      return EmptyListWidget();
    else
      return Form(
        key: cubit.createContentFormKey,
        child: ListView(
          padding: AppInsets.horizontalInsets36,
          children: [
            AppSpacing.verticalSpace32,
            Text('Добавить контент', style: AppTextStyles.title.copyWith(color: AppColors.white)),
            AppSpacing.verticalSpace16,
            CustomTextField(
              fillColor: AppColors.darkBlue,
              labelText: 'Название элемента',
              controller: cubit.contentTitleController,
              labelColor: AppColors.white,
              inputTextColor: AppColors.white,
              validator: (value) {
                if (value?.isEmpty ?? false)
                  return 'Это обязательное поле';
                else
                  return null;
              },
            ),
            AppSpacing.verticalSpace32,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    fillColor: AppColors.darkBlue,
                    labelText: 'Ширина элемента',
                    controller: cubit.contentWidthController,
                    inputTextColor: AppColors.white,
                    labelColor: AppColors.white,
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
                    fillColor: AppColors.darkBlue,
                    inputTextColor: AppColors.white,
                    labelText: 'Высота элемента',
                    controller: cubit.contentHeightController,
                    labelColor: AppColors.white,
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
            AppSpacing.verticalSpace32,
            if (widget.categories.isEmpty)
              CustomButton.text(
                text: 'Добавить категорию',
                onTap: () => showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AddDecorationCategory(),
                ).then((value) => cubit.showMessage(value ?? '')),
                color: AppColors.darkBlue,
              ),
            if (widget.categories.isNotEmpty)
              Wrap(
                children: [
                  for (final category in widget.categories)
                    DecorationCategoryCard(
                      category: category,
                      onTap: () => setState(() => selectedCategory = category),
                      isSelected: selectedCategory == category,
                    ),
                  TextButton(
                    onPressed: () => showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AddDecorationCategory(),
                    ).then((value) => cubit.showMessage(value ?? '')),
                    child: Text('Добавить категорию'),
                  ),
                ],
                runSpacing: 16,
                spacing: 16,
              ),
            AppSpacing.verticalSpace16,
            Text('Выберите файл', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
            AppSpacing.verticalSpace16,
            FilePickerWidget(
              initialWidget: Center(
                child: Text(
                  'Нажмите здесь чтобы выбрать файл',
                  style: AppTextStyles.title.copyWith(color: AppColors.white),
                ),
              ),
              onFileSelected: (files) {
                if (files.isNotEmpty) cubit.changeSelectedFile(files.first);
              },
            ),
            AppSpacing.verticalSpace16,
            CustomButton.text(
              text: 'Сохранить',
              onTap: () => cubit.saveData(selectedCategory),
              color: AppColors.darkBlue,
              textStyle: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
            ),
            AppSpacing.verticalSpace16,
          ],
        ),
      );
  }
}
