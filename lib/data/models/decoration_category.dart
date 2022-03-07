class DecorationCategory {
  final Map<String, dynamic> typeMasks;
  final String type;

  DecorationCategory({
    required this.typeMasks,
    required this.type,
  });

  factory DecorationCategory.fromJson(Map<String, dynamic> data) => DecorationCategory(
        type: data['type'],
        typeMasks: data['type_masks'],
      );

  Map<String, dynamic> get toMap => {
        'type': type,
        'type_masks': typeMasks,
      };
}
