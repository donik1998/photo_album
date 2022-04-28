import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/data/services/auth_service.dart';
import 'package:photo_album/presentation/custom_widgets/resolution_template.dart';
import 'package:photo_album/presentation/custom_widgets/templates_widget.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/search.dart';
import 'package:photo_album/presentation/state/main_page/main_page_body_state.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';

class MainPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageBodyState>(
      builder: (context, state, child) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: AppInsets.horizontalInsets16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.verticalSpace4,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 36,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SearchPage(
                          decorationCategories: state.decorationCategories,
                          albumPageTemplateCategory: state.templateCategories,
                          albumDecorations: state.albumBacks,
                        );
                      }));
                    },
                    child: Container(
                      width: 299,
                      height: 36,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            Text('Поиск'),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F3F3),
                      ),
                    ),
                  ),
                  AppSpacing.horizontalSpace16,
                  GestureDetector(
                    onTap: () => AuthService.instance.signOut(),
                    child: Image.asset('assets/images/app_logo.png'),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalSpace16,
            Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 156,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Rectangle 386.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: AppInsets.insetsAll16,
                  child: Text('Создавайте альбомы со своими истроиями',
                      style: AppTextStyles.ttxt),
                ),
              ],
            ),
            AppSpacing.verticalSpace32,
            Text('Создайте свой альбом', style: AppTextStyles.ttxt1),
            AppSpacing.verticalSpace24,
            ResolutionTemplate(sizes: ['20x20', '23x23', '25x25']),
            if (state.loading)
              Expanded(child: Center(child: CircularProgressIndicator())),
            for (final templateCategory in state.templateCategories)
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('album_page_templates')
                    .where('type', isEqualTo: templateCategory.value)
                    .get(),
                builder: (context, templatesSnapshot) {
                  if (templatesSnapshot.connectionState ==
                      ConnectionState.waiting)
                    return Container();
                  else
                    return TemplatesRowWidget(
                      templates: templatesSnapshot.data!.docs
                          .map((e) => AlbumPageTemplate.fromJson(e.data()))
                          .toList(),
                      showTopSpacing: true,
                      title: templateCategory.masks['ru'],
                      type: templateCategory.value,
                      onTemplateChosen: (template) => Navigator.pushNamed(
                        context,
                        AppRoutes.EDITOR_PAGE,
                        arguments: RedactorPageArgs(
                          decorationCategories: context
                              .read<MainPageBodyState>()
                              .decorationCategories,
                          albumBacks:
                              context.read<MainPageBodyState>().albumBacks,
                          albumPageTemplateCategories: context
                              .read<MainPageBodyState>()
                              .templateCategories,
                          backImage: CachedNetworkImage(
                              imageUrl: template.downloadLinks.first),
                        ),
                      ),
                    );
                },
              ),
          ],
        ),
      ),
    );
  }
}
