import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/element_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class ElementsSheet extends StatefulWidget {
  final ScrollController controller;

  const ElementsSheet({Key? key, required this.controller}) : super(key: key);

  @override
  _ElementsSheetState createState() => _ElementsSheetState();
}

class _ElementsSheetState extends State<ElementsSheet> {
  List<DecorationCategory> decorationCategories = List.empty();
  DecorationCategory? _selectedCategory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {});
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final categories = await FirebaseFirestore.instance.collection('categories').get();
      decorationCategories = List.from(
        categories.docs.map((e) => DecorationCategory.fromJson(e.data())),
      );
      setState(() {
        _isLoading = false;
        if (decorationCategories.isNotEmpty) _selectedCategory = decorationCategories.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Loader();
    else if (decorationCategories.isEmpty)
      return EmptyListWidget(message: 'Не удалось найти элементы');
    else
      return Padding(
        padding: AppInsets.horizontalInsets16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.verticalSpace10,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: decorationCategories.map((category) {
                  bool isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CustomButton.text(
                      text: category.titleMasks['ru'],
                      onTap: () => setState(() => _selectedCategory = category),
                      textStyle: AppTextStyles.smallTitleBold.copyWith(color: isSelected ? AppColors.white : AppColors.black),
                      color: isSelected ? AppColors.pinkLight : AppColors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
            AppSpacing.verticalSpace10,
            Divider(),
            Expanded(
              child: _selectedCategory == null
                  ? EmptyListWidget(message: 'Не удалось найти элементы в выбранной категории')
                  : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('decorations')
                          .where(
                            'category',
                            isEqualTo: _selectedCategory?.title,
                          )
                          .get(),
                      builder: (context, decorationsSnapshot) {
                        if (decorationsSnapshot.connectionState == ConnectionState.waiting) {
                          return Loader();
                        } else if (!decorationsSnapshot.hasData) {
                          return Center(child: Text('Тут пусто'));
                        } else {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemCount: decorationsSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final decoration = DecorationElement.fromMap(decorationsSnapshot.data!.docs.elementAt(index).data());
                              return ElementCard(
                                title: decoration.title,
                                imageLink: decoration.downloadLink,
                                onTap: () => Navigator.pop(context, decoration),
                              );
                            },
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      );
  }
}
