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
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      bloc: context.read<ProfilePageCubit>(),
      builder: (context, state) {
        if (state is ProfileLoading)
          return Loader();
        else
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Меню', style: AppTextStyles.ttxt1),
              AppSpacing.verticalSpace32,
              ListTile(
                leading: CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: FirebaseAuth.instance.currentUser?.photoURL ?? '',
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline)),
                  ),
                ),
                title: Text(FirebaseAuth.instance.currentUser?.displayName ?? '', style: AppTextStyles.ttxt),
                subtitle: Text('Изменить фото', style: AppTextStyles.smallPinkText),
                trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ),
              AppSpacing.verticalSpace24,
              Divider(thickness: 0.5),
              ListTile(leading: Icon(Icons.image_outlined), title: Text('Фото')),
              AppSpacing.verticalSpace24,
              ListTile(leading: SvgPicture.asset('assets/svgs/book.svg'), title: Text('Фото')),
              AppSpacing.verticalSpace24,
              ListTile(leading: SvgPicture.asset('assets/svgs/dollar.svg'), title: Text('Фото')),
              AppSpacing.verticalSpace24,
              Divider(thickness: 0.5),
              ListTile(
                leading: Icon(Icons.add, color: AppColors.pinkLight),
                title: Text(
                  'Пригласить',
                  style: AppTextStyles.title.copyWith(fontSize: 14, color: AppColors.pinkLight),
                ),
              ),
              Divider(thickness: 0.5),
              const SizedBox(height: 108),
              Image.asset('assets/images/profile.png'),
            ],
          );
      },
      listener: (context, state) {},
    );
  }
}
