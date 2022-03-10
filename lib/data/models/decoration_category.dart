class DecorationCategory {
  final String title;
  final Map<String, dynamic> titleMasks;

  DecorationCategory({
    required this.title,
    required this.titleMasks,
  });

  factory DecorationCategory.fromJson(Map<String, dynamic> data) => DecorationCategory(
        title: data['type'],
        titleMasks: data['type_masks'],
      );
}
