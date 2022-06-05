import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/change_name_sheet.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/pick_image_sheet.dart';
import 'package:photo_album/presentation/state/main_page/profile_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/app_runtime_notifier.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageState>(
      builder: (context, state, child) {
        return Padding(
          padding: AppInsets.insetsAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Меню', style: AppTextStyles.ttxt1),
              AppSpacing.verticalSpace32,
              ListTile(
                leading: CachedNetworkImage(
                  width: 48,
                  height: 48,
                  imageUrl: FirebaseAuth.instance.currentUser?.photoURL ?? '',
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline)),
                  imageBuilder: (context, image) => ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image(image: image, fit: BoxFit.cover),
                  ),
                ),
                title: Text(FirebaseAuth.instance.currentUser?.displayName ?? 'Имя не указано', style: AppTextStyles.smallTitleBold),
                subtitle: Text('Изменить фото', style: AppTextStyles.smallPinkText),
                trailing: PopupMenuButton(
                  icon: SvgPicture.asset('assets/svgs/more_vertical.svg'),
                  shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(16))),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Изменить имя'),
                      value: 'change_name',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'change_name') {
                      AppRuntimeNotifier.instance.showCustomBottomSheet(
                        context: context,
                        sheet: ChangeNameSheet(
                          formKey: state.formKey,
                          nameController: state.nameController,
                          onSaved: () async {
                            final message = await state.onNameSaved();
                            if (message.isNotEmpty) {
                              AppRuntimeNotifier.instance.showSnack(context: context, message: message);
                            }
                          },
                        ),
                      );
                    }
                  },
                  elevation: 5,
                ),
                onTap: () => AppRuntimeNotifier.instance.showCustomBottomSheet(
                  context: context,
                  sheet: PickImageSheet(
                    onSourceChosen: (source) async {
                      showDialog(
                        context: context,
                        builder: (context) => Center(child: CircularProgressIndicator()),
                        barrierDismissible: false,
                      );
                      final message = await state.uploadPhoto(source: source);
                      Navigator.pop(context);
                      AppRuntimeNotifier.instance.showSnack(context: context, message: message);
                    },
                  ),
                ),
              ),
              AppSpacing.verticalSpace16,
              Divider(thickness: 0.5),
              SizedBox(
                height: 48,
                child: ListTile(
                  leading: SvgPicture.asset('assets/svgs/book_bold.svg'),
                  title: Text('Мои альбомы'),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.ALL_LOCAL_ALBUMS),
                ),
              ),
              AppSpacing.verticalSpace16,
              Divider(thickness: 0.5),
              ListTile(
                leading: Icon(Icons.add, color: AppColors.pinkLight),
                title: Text(
                  'Пригласить',
                  style: AppTextStyles.title.copyWith(fontSize: 14, color: AppColors.pinkLight),
                ),
                onTap: () {
                  launchUrl(Uri.parse(''), mode: LaunchMode.platformDefault);
                },
              ),
              Divider(thickness: 0.5),
              Spacer(),
              Center(child: Image.asset('assets/images/profile.png')),
              AppSpacing.verticalSpace20,
              AppSpacing.verticalSpace20,
              AppSpacing.verticalSpace20,
            ],
          ),
        );
      },
    );
  }
}
