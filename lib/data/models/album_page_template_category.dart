class AlbumPageTemplateCategory {
  final Map<String, dynamic> masks;
  final String value;

  AlbumPageTemplateCategory({
    required this.masks,
    required this.value,
  });

  factory AlbumPageTemplateCategory.fromJson(Map<String, dynamic> data) => AlbumPageTemplateCategory(
        masks: data['type_mask'],
        value: data['type'],
      );
}
