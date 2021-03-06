import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppInsets.horizontalInsets16,
      children: [
        Text('Меню', style: AppTextStyles.ttxt1),
        AppSpacing.verticalSpace32,
        SizedBox(
          height: 48,
          child: ListTile(
            leading: CachedNetworkImage(
              width: 48,
              height: 48,
              imageUrl: FirebaseAuth.instance.currentUser?.photoURL ?? '',
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline)),
              imageBuilder: (context, image) => ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image(image: image),
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
  }
}
