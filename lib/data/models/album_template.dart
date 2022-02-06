abstract class Album {
  final String title;
  final String thumbnailLink;
  final double widthCm;
  final double heightCm;
  final double widthInch;
  final double heightInch;

  Album({
    required this.title,
    required this.thumbnailLink,
    required this.widthCm,
    required this.heightCm,
    required this.widthInch,
    required this.heightInch,
  });
}
