import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/template_page_model.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/album_templates_body/widgets/album_page_template_card.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumPageTemplatesBody extends StatefulWidget {
  const AlbumPageTemplatesBody({Key? key}) : super(key: key);

  @override
  State<AlbumPageTemplatesBody> createState() => _AlbumPageTemplatesBodyState();
}

class _AlbumPageTemplatesBodyState extends State<AlbumPageTemplatesBody> {
  String _currentAlbumPageTemplateType = '';
  bool _isLoading = true;
  List<Map<String, dynamic>> templateCategories = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final templateCategoryDocs = await FirebaseFirestore.instance.collection('album_template_page_types').get();
      setState(() {
        templateCategories = List.from(templateCategoryDocs.docs.map((e) => e.data()));
        _currentAlbumPageTemplateType = templateCategories.first['type'];
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Loader();
    else if (templateCategories.isEmpty)
      return EmptyListWidget();
    else
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Тип шаблонов страниц', style: AppTextStyles.smallTitleBold.copyWith(color: Colors.white)),
                DropdownButton<String>(
                  underline: SizedBox(),
                  value: _currentAlbumPageTemplateType,
                  borderRadius: BorderRadius.circular(16),
                  dropdownColor: AppColors.darkBlue,
                  elevation: 0,
                  focusColor: AppColors.darkBlue,
                  itemHeight: 48,
                  items: templateCategories
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e['type'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e['type_mask']['ru'], style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _currentAlbumPageTemplateType = value ?? ''),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('album_page_templates')
                    .where('type', isEqualTo: _currentAlbumPageTemplateType)
                    .snapshots(),
                builder: (context, templatesSnapshot) {
                  if (templatesSnapshot.connectionState == ConnectionState.waiting)
                    return Loader();
                  else if (templatesSnapshot.data?.docs.isEmpty ?? false)
                    return EmptyListWidget();
                  else
                    return GridView.builder(
                      itemCount: templatesSnapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final template = AlbumPageTemplate.fromJson(templatesSnapshot.data!.docs.elementAt(index).data());
                        return AlbumPageTemplateCard(template: template);
                      },
                    );
                },
              ),
            ),
          ],
        ),
      );
  }
}
