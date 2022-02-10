import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

import 'bloc/profile_page_cubit.dart';
import 'bloc/profile_page_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfilePageCubit>();
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is ProfileLoading)
          return Loader();
        else
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Меню', style: AppTextStyles.ttxt1),
              AppSpacing.verticalSpace32,
              SizedBox(
                height: 48,
                child: ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.black, width: 1.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: FirebaseAuth.instance.currentUser?.photoURL ?? '',
                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline)),
                    ),
                  ),
                  title: Text(FirebaseAuth.instance.currentUser?.displayName ?? 'Имя не указано', style: AppTextStyles.smallTitleBold),
                  subtitle: Text('Изменить фото', style: AppTextStyles.smallPinkText),
                  trailing: SvgPicture.asset('assets/svgs/more_vertical.svg'),
                ),
              ),
              AppSpacing.verticalSpace16,
              Divider(thickness: 0.5),
              SizedBox(
                height: 48,
                child: ListTile(leading: SvgPicture.asset('assets/svgs/image.svg'), title: Text('Фото')),
              ),
              AppSpacing.verticalSpace16,
              SizedBox(
                height: 48,
                child: ListTile(leading: SvgPicture.asset('assets/svgs/book_bold.svg'), title: Text('Мои альбомы')),
              ),
              AppSpacing.verticalSpace16,
              SizedBox(
                height: 48,
                child: ListTile(leading: SvgPicture.asset('assets/svgs/dollar.svg'), title: Text('Оплата')),
              ),
              AppSpacing.verticalSpace16,
              Divider(thickness: 0.5),
              ListTile(
                leading: Icon(Icons.add, color: AppColors.pinkLight),
                title: Text(
                  'Пригласить',
                  style: AppTextStyles.title.copyWith(fontSize: 14, color: AppColors.pinkLight),
                ),
              ),
              Divider(thickness: 0.5),
              Expanded(child: SizedBox()),
              Image.asset('assets/images/profile.png'),
              AppSpacing.verticalSpace20,
              AppSpacing.verticalSpace20,
            ],
          );
      },
      listener: (context, state) {},
    );
  }
}
