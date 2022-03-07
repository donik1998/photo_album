class AlbumPageTemplateCategory {
  final String type;
  final Map<String, dynamic> masks;

  AlbumPageTemplateCategory({
    required this.type,
    required this.masks,
  });

  factory AlbumPageTemplateCategory.fromJson(Map<String, dynamic> data) => AlbumPageTemplateCategory(
        type: data['type'],
        masks: data['type_masks'],
      );
}
