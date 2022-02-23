import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/widgets/file_picker.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageAddContentBody extends StatelessWidget {
  const HomePageAddContentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Form(
      key: cubit.createContentFormKey,
      child: ListView(
        padding: AppInsets.horizontalInsets36,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Категория элемента', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                    DropdownButton<String>(
                      underline: SizedBox(),
                      value: cubit.createDecorationElementChosenType,
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: AppColors.darkBlue,
                      elevation: 0,
                      focusColor: AppColors.darkBlue,
                      itemHeight: 48,
                      items: [
                        DropdownMenuItem<String>(
                          child: Padding(
                            padding: AppInsets.horizontalInsets16,
                            child: Text('Стикер', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                          value: DecorationElementTypes.STICKER,
                        ),
                        DropdownMenuItem<String>(
                          child: Padding(
                            padding: AppInsets.horizontalInsets16,
                            child: Text('Анимация', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                          value: DecorationElementTypes.ANIMATION,
                        ),
                        DropdownMenuItem<String>(
                          child: Padding(
                            padding: AppInsets.horizontalInsets16,
                            child: Text('Шрифт', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                          value: DecorationElementTypes.FONT,
                        ),
                      ],
                      onChanged: (value) => cubit.changeCreatingElementType(value),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSpace20,
              AppSpacing.horizontalSpace20,
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Тип элемента', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                    DropdownButton<String>(
                      underline: SizedBox(),
                      value: cubit.createDecorationElementChosenType,
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: AppColors.darkBlue,
                      elevation: 0,
                      focusColor: AppColors.darkBlue,
                      itemHeight: 48,
                      items: [
                        DropdownMenuItem<String>(
                          child: Padding(
                            padding: AppInsets.horizontalInsets16,
                            child: Text('Стикер', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                          value: DecorationElementTypes.STICKER,
                        ),
                        DropdownMenuItem<String>(
                          child: Padding(
                            padding: AppInsets.horizontalInsets16,
                            child: Text('Анимация', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                          value: DecorationElementTypes.ANIMATION,
                        ),
                        DropdownMenuItem<String>(
                          child: Padding(
                            padding: AppInsets.horizontalInsets16,
                            child: Text('Шрифт', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                          value: DecorationElementTypes.FONT,
                        ),
                      ],
                      onChanged: (value) => cubit.changeCreatingElementType(value),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpace16,
          Text('Выберите файл', style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
          AppSpacing.verticalSpace16,
          FilePickerWidget(
            onFileSelected: (files) {
              if (files.isNotEmpty) cubit.changeSelectedFile(files.first);
            },
          ),
          AppSpacing.verticalSpace16,
          CustomButton.text(
            text: 'Сохранить',
            onTap: () => cubit.saveData(),
            color: AppColors.darkBlue,
            textStyle: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
          ),
          AppSpacing.verticalSpace16,
        ],
      ),
    );
  }
}
