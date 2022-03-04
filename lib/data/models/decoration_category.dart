class DecorationCategory {
  final String title;
  final List<String> docs;
  final Map<String, dynamic> titleMasks;

  DecorationCategory({
    required this.title,
    required this.docs,
    required this.titleMasks,
  });

  factory DecorationCategory.fromJson(Map<String, dynamic> data) => DecorationCategory(
        title: data['title'],
        docs: data['category_docs'].map<String>((e) => e.toString()).toList(),
        titleMasks: data['title_masks'],
      );
}
