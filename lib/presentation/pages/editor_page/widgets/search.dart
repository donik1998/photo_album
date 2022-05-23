import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/models/searchModel.dart';
import 'package:photo_album/presentation/custom_widgets/custom_textfield.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class SearchPage extends StatefulWidget {
  final List<DecorationCategory> decorationCategories;
  final List<AlbumPageTemplateCategory> albumPageTemplateCategory;
  final List<AlbumDecoration> albumDecorations;

  const SearchPage({
    Key? key,
    required this.decorationCategories,
    required this.albumPageTemplateCategory,
    required this.albumDecorations,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchModel> _searchItems = List.empty(growable: true);
  List<SearchModel> _filteredItems = List.empty(growable: true);
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchItems.addAll(
      List.from(
        widget.decorationCategories.map(
          (e) => SearchModel<DecorationCategory>(title: e.title, widthCm: 0, heightCm: 0, widthInch: 0, heightInch: 0, data: e),
        ),
      ),
    );
    _searchItems.addAll(
      List.from(
        widget.albumDecorations.map(
          (e) => SearchModel<AlbumDecoration>(
            title: e.title,
            widthCm: e.width,
            heightCm: e.height,
            widthInch: e.width,
            heightInch: e.height,
            data: e,
          ),
        ),
      ),
    );
    _searchItems.addAll(
      List.from(
        widget.albumPageTemplateCategory.map(
          (e) => SearchModel<AlbumPageTemplateCategory>(title: e.value, widthCm: 0, heightCm: 0, widthInch: 0, heightInch: 0, data: e),
        ),
      ),
    );
    _searchItems.addAll(List.from(widget.albumDecorations.map(
        (e) => SearchModel(title: e.title, widthCm: e.width, heightCm: e.height, widthInch: e.width, heightInch: e.height, data: e))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: KeyboardDismisser(
        child: Column(
          children: [
            Padding(
              padding: AppInsets.horizontalInsets16,
              child: CustomTextField(
                autofocus: true,
                onTap: () {},
                prefixIcon: Icon(Icons.search, color: Colors.black),
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => _searchController.clear()),
                  child: Icon(Icons.close, color: Colors.black),
                ),
                controller: _searchController,
                onChanged: (value) => setState(() {
                  if (value.isEmpty) {
                    _filteredItems.clear();
                  } else {
                    _filteredItems =
                        _searchItems.where((searchModel) => searchModel.title.toUpperCase().contains(value.toUpperCase())).toList();
                  }
                }),
              ),
            ),
            AppSpacing.verticalSpace16,
            Expanded(
              child: ListView.separated(
                padding: AppInsets.horizontalInsets16,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) => SearchItemWidget(onTap: () {}, item: _filteredItems.elementAt(index)),
                separatorBuilder: (context, index) => AppSpacing.verticalSpace16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItemWidget extends StatelessWidget {
  final SearchModel item;
  final VoidCallback onTap;

  const SearchItemWidget({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 48,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset('assets/svgs/book_bold.svg'),
              AppSpacing.horizontalSpace8,
              Text(
                item.title,
                style: AppTextStyles.smallTitleBold,
              ),
              AppSpacing.horizontalSpace8,
              Text('${item.widthCm}x${item.heightCm}', style: AppTextStyles.smallText),
            ],
          ),
        ),
      ),
    );
  }
}
