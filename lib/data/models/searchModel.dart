class SearchModel<T> {
  final String title;
  final double widthCm;
  final double heightCm;
  final double widthInch;
  final double heightInch;
  final T data;

  SearchModel({
    required this.title,
    required this.widthCm,
    required this.heightCm,
    required this.widthInch,
    required this.heightInch,
    required this.data,
  });
}
