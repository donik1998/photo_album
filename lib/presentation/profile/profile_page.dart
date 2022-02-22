import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/services/auth_service.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Padding(
      padding: AppInsets.horizontalInsets16,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Меню', style: AppTextStyles.ttxt1),
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => Center(child: CircularProgressIndicator()),
                  );
                  await AuthService.instance.signOut();
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/images/Logo_small.png'),
              ),
            ],
          ),
          AppSpacing.verticalSpace32,
          SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CachedNetworkImage(
                  imageUrl: FirebaseAuth.instance.currentUser?.photoURL ?? '',
                  width: 48,
                  height: 48,
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline)),
                  imageBuilder: (context, image) => ClipOval(child: Image(image: image)),
                ),
                AppSpacing.horizontalSpace16,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: FirebaseAuth.instance.currentUser?.displayName ?? 'Имя не указано',
                          style: AppTextStyles.smallTitleBold,
                        ),
                        TextSpan(text: '\nИзменить фото', style: AppTextStyles.smallPinkText),
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset('assets/svgs/more_vertical.svg')
              ],
            ),
          ),
          AppSpacing.verticalSpace16,
          Divider(thickness: 0.5),
          SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svgs/image.svg'),
                AppSpacing.horizontalSpace12,
                Text('Фото'),
              ],
            ),
          ),
          AppSpacing.verticalSpace16,
          SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset('assets/svgs/book_bold.svg'),
                AppSpacing.horizontalSpace12,
                Text('Мои альбомы'),
              ],
            ),
          ),
          AppSpacing.verticalSpace16,
          SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset('assets/svgs/dollar.svg'),
                AppSpacing.horizontalSpace12,
                Text('Оплата'),
              ],
            ),
          ),
          AppSpacing.verticalSpace16,
          Divider(thickness: 0.5),
          SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.add, color: AppColors.pinkLight),
                AppSpacing.horizontalSpace12,
                Text(
                  'Пригласить',
                  style: AppTextStyles.title.copyWith(fontSize: 14, color: AppColors.pinkLight),
                ),
              ],
            ),
          ),
          Divider(thickness: 0.5),
          Expanded(child: SizedBox()),
          Image.asset('assets/images/profile.png', width: 155, height: 152),
          AppSpacing.verticalSpace20,
          AppSpacing.verticalSpace20,
        ],
      ),
    );
  }
}
