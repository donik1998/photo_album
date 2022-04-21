import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/add_decoration_elements_body/widgets/decoration_category_card.dart';
import 'package:photo_album/presentation/home_page/widgets/decoration_element_card.dart';
import 'package:photo_album/presentation/home_page/widgets/decoration_element_editor_dialog.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageDecorationElementsBody extends StatefulWidget {
  final List<DecorationCategory> categories;

  const HomePageDecorationElementsBody({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<HomePageDecorationElementsBody> createState() => _HomePageDecorationElementsBodyState();
}

class _HomePageDecorationElementsBodyState extends State<HomePageDecorationElementsBody> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  DecorationCategory? _currentAlbumPageTemplateType;

  @override
  void initState() {
    super.initState();
    if (widget.categories.isNotEmpty) _currentAlbumPageTemplateType = widget.categories.first;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Text('Тип шаблонов страниц', style: AppTextStyles.smallTitleBold.copyWith(color: Colors.white)),
              AppSpacing.horizontalSpace20,
              for (final category in widget.categories)
                DecorationCategoryCard(
                  category: category,
                  onTap: () => setState(() => _currentAlbumPageTemplateType = category),
                  isSelected: _currentAlbumPageTemplateType == category,
                ),
            ],
          ),
          AppSpacing.verticalSpace24,
          if (_currentAlbumPageTemplateType == null) Expanded(child: EmptyListWidget()),
          if (_currentAlbumPageTemplateType != null)
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('decorations')
                    .where('type', isEqualTo: _currentAlbumPageTemplateType!.type)
                    .snapshots(),
                builder: (context, elementsSnapshot) {
                  if (elementsSnapshot.connectionState == ConnectionState.waiting)
                    return Loader();
                  else if (elementsSnapshot.hasData && (elementsSnapshot.data?.docs.isEmpty ?? false))
                    return EmptyListWidget();
                  else
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: elementsSnapshot.data!.size,
                      itemBuilder: (context, index) {
                        final dataMap = elementsSnapshot.data!.docs.elementAt(index).data();
                        dataMap['id'] = elementsSnapshot.data!.docs.elementAt(index).id;
                        final element = DecorationElement.fromMap(dataMap);
                        return DecorationElementCard(
                          element: element,
                          onDelete: () => deleteDecorationItem(
                            reference: elementsSnapshot.data!.docs.elementAt(index).reference,
                            url: element.downloadLink,
                          ),
                          onEdit: () => showDialog(
                            context: context,
                            builder: (context) => DecorationElementEditorDialog(element: element, categories: widget.categories),
                          ),
                        );
                      },
                    );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> deleteDecorationItem({required DocumentReference reference, required String url}) async {
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()));
    final storageRef = await FirebaseStorage.instance.refFromURL(url);
    await storageRef.delete();
    await reference.delete();
    Navigator.pop(context);
  }
}
