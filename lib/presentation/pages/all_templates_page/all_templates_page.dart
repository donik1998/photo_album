import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/presentation/custom_widgets/element_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';

class AllTemplatesPage extends StatelessWidget {
  const AllTemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AllTemplatesPageArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.templateType,
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppSpacing.verticalSpace16,
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('album_page_templates')
                    .where('type', isEqualTo: args.templateType)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Loader();
                  else if (!snapshot.hasData) return EmptyListWidget(message: 'Шаблоны по заданному типу не найдены');
                  return GridView.builder(
                    padding: AppInsets.horizontalInsets16,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final template = AlbumPageTemplate.fromJson(snapshot.data!.docs.elementAt(index).data());
                      return ElementCard(
                        title: template.title,
                        imageLink: template.downloadLinks.first,
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
