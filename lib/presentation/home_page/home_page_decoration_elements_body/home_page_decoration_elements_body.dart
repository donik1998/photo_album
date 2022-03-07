import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/widgets/decoration_element_card.dart';
import 'package:photo_album/presentation/home_page/widgets/decoration_element_editor_dialog.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageDecorationElementsBody extends StatefulWidget {
  const HomePageDecorationElementsBody({Key? key}) : super(key: key);

  @override
  State<HomePageDecorationElementsBody> createState() => _HomePageDecorationElementsBodyState();
}

class _HomePageDecorationElementsBodyState extends State<HomePageDecorationElementsBody> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  List<DecorationCategory> _decorationCats = List.empty();
  String? _currentAlbumPageTemplateType;

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async {
        final categoryDocs = await FirebaseFirestore.instance.collection('categories').get();
        setState(() {
          _decorationCats = List.from(categoryDocs.docs.map((e) => DecorationCategory.fromJson(e.data())));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<HomePageCubit>();
    if (_decorationCats.isEmpty)
      return EmptyListWidget();
    else
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  items: _decorationCats
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e.type,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.typeMasks['ru'], style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white)),
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
                    .collection('decorations')
                    .where('type', isEqualTo: _currentAlbumPageTemplateType)
                    .snapshots(),
                builder: (context, elementsSnapshot) {
                  if (elementsSnapshot.connectionState == ConnectionState.waiting)
                    return Loader();
                  else if (elementsSnapshot.hasData && (elementsSnapshot.data?.docs.isEmpty ?? false))
                    return EmptyListWidget();
                  else
                    return GridView.builder(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
                      itemBuilder: (context, index) {
                        final element = DecorationElement.fromMap(elementsSnapshot.data!.docs.elementAt(index).data());
                        return DecorationElementCard(
                          element: element,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => DecorationElementEditorDialog(element: element),
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
}
