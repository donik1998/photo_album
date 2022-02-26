class ContentCategory {
  final String categoryTitle;
  final List<String> categoryDocs;

  ContentCategory({
    required this.categoryTitle,
    required this.categoryDocs,
  });

  factory ContentCategory.fromJson(Map<String, dynamic> data) => ContentCategory(
        categoryTitle: data['title'],
        categoryDocs: data['category_docs'].map<String>((e) => e.toString()).toList(),
      );

  Map<String, dynamic> get toMap => {
        'title': this.categoryTitle,
        'category_docs': this.categoryDocs,
      };

  void addCategoryDocId(String newDocId) => categoryDocs.add(newDocId);
}
