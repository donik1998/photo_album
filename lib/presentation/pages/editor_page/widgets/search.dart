import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/models/searchModel.dart';

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

  @override
  void initState() {
    super.initState();
    _searchItems.addAll(
      List.from(
        widget.decorationCategories.map(
          (e) => SearchModel<DecorationCategory>(
            title: e.title,
            widthCm: 0,
            heightCm: 0,
            widthInch: 0,
            heightInch: 0,
            data: e,
          ),
        ),
      ),
    );
    _searchItems.addAll(List.from(widget.albumDecorations.map((e) =>
        SearchModel<AlbumDecoration>(
            title: e.title,
            widthCm: e.width,
            heightCm: e.height,
            widthInch: e.width,
            heightInch: e.height,
            data: e))));
    _searchItems.addAll(
      List.from(
        widget.albumPageTemplateCategory.map(
          (e) => SearchModel<AlbumPageTemplateCategory>(
            title: e.value,
            widthCm: 0,
            heightCm: 0,
            widthInch: 0,
            heightInch: 0,
            data: e,
          ),
        ),
      ),
    );
    _searchItems.addAll(List.from(widget.albumDecorations.map((e) => SearchModel(title: e.title, widthCm: e.width, heightCm: e.height, widthInch: e.width, heightInch: e.height, data: e))));
    _filteredItems = _searchItems;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _filteredItems = _searchItems
                  .where((searchModel) => searchModel.title.toUpperCase().contains(value.toUpperCase()))
                  .toList();
            });
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: ListView.builder(
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white38,
                child: Container(
                    width: 50,
                    height: 70,
                    child: Center(child: Text(_filteredItems.elementAt(index).title))));
          }),
    );
  }
}
