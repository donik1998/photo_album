import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/presentation/custom_widgets/custom_textfield.dart';
import 'package:photo_album/presentation/custom_widgets/resolution_template.dart';
import 'package:photo_album/presentation/custom_widgets/templates_widget.dart';
import 'package:photo_album/presentation/state/main_page/main_page_body_state.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:photo_album/some_code/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

class MainPageBody extends StatelessWidget {
  const MainPageBody({Key? key}) : super(key: key);

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
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ),
              ),
              child: Text('Go to some_code'),
            ),
            AppSpacing.verticalSpace4,
            CustomTextField(
              onTap: () => state.toggleSearchBarAvailability(),
              controller: state.textController,
              enabled: state.searchBarEnabled,
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
                    image: DecorationImage(image: AssetImage('assets/images/Rectangle 386.png'), fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: AppInsets.insetsAll16,
                  child: Text('Создавайте альбомы со своими истроиями', style: AppTextStyles.ttxt),
                ),
              ],
            ),
            AppSpacing.verticalSpace32,
            Text('Создайте свой альбом', style: AppTextStyles.ttxt1),
            AppSpacing.verticalSpace24,
            ResolutionTemplate(sizes: ['20x20', '23x23', '25x25']),
            if (state.loading) Expanded(child: Center(child: CircularProgressIndicator())),
            for (final templateCategory in state.templateCategories)
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('album_page_templates')
                    .where('type', isEqualTo: templateCategory.value)
                    .get(),
                builder: (context, templatesSnapshot) {
                  if (templatesSnapshot.connectionState == ConnectionState.waiting)
                    return Container();
                  else
                    return TemplatesRowWidget(
                      templates: templatesSnapshot.data!.docs.map((e) => AlbumPageTemplate.fromJson(e.data())).toList(),
                      showTopSpacing: true,
                      title: templateCategory.masks['ru'],
                      type: templateCategory.value,
                      onTemplateChosen: (template) => Navigator.pushNamed(
                        context,
                        AppRoutes.EDITOR_PAGE,
                        arguments: RedactorPageArgs(
                          decorationCategories: context.read<MainPageBodyState>().decorationCategories,
                          albumPageTemplateCategories: context.read<MainPageBodyState>().templateCategories,
                          backImage: CachedNetworkImage(imageUrl: template.downloadLinks.first),
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
