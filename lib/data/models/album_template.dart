import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/data/local/database.dart';
import 'package:photo_album/data/models/decoration_element.dart';

class AlbumModel {
  final String title;
  final String type;
  final double widthCm;
  final double heightCm;
  final double widthInch;
  final double heightInch;
  final List<AlbumPage> pages;
  final AlbumCover cover;

  AlbumModel({
    required this.pages,
    required this.cover,
    required this.title,
    required this.type,
    required this.widthCm,
    required this.heightCm,
    required this.widthInch,
    required this.heightInch,
  });

  factory AlbumModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> data) => AlbumModel(
        title: data['title'],
        type: data['type'],
        widthCm: data['width_cm'],
        heightCm: data['height_cm'],
        widthInch: data['width_inch'],
        heightInch: data['height_inch'],
        cover: AlbumCover.fromMap(data.get('album_cover')),
        pages: data.get('pages').map((entry) => AlbumPage.fromMap(entry)).toList(),
      );

  Map<String, dynamic> get toMap => {
        'title': this.title,
        'type': this.type,
        'width_cm': this.widthCm,
        'height_cm': this.heightCm,
        'width_inch': this.widthInch,
        'height_inch': this.heightInch,
        'album_cover': this.cover.toMap,
        'pages': this.pages.map((e) => e.toMap).toList(),
      };

  Album get databaseModel => Album(
        title: title,
        type: type,
        widthCm: widthCm,
        heightCm: heightCm,
        widthInch: widthInch,
        heightInch: heightInch,
        cover: jsonEncode(cover.toMap),
        pages: jsonEncode(pages.map((e) => e.toMap).toList()),
      );

  factory AlbumModel.fromLocalAlbum(Album localAlbum) {
    final cover = AlbumCover.fromMap(jsonDecode(localAlbum.cover));
    final pages = jsonDecode(localAlbum.pages).map<AlbumPage>((entry) => AlbumPage.fromMap(entry)).toList();
    return AlbumModel(
      pages: pages,
      cover: cover,
      title: localAlbum.title,
      type: localAlbum.type,
      widthCm: localAlbum.widthCm,
      heightCm: localAlbum.heightCm,
      widthInch: localAlbum.widthInch,
      heightInch: localAlbum.heightInch,
    );
  }

  AlbumModel copyWith({
    String? title,
    String? type,
    double? widthCm,
    double? heightCm,
    double? widthInch,
    double? heightInch,
    List<AlbumPage>? pages,
    AlbumCover? cover,
  }) =>
      AlbumModel(
        pages: pages ?? this.pages,
        cover: cover ?? this.cover,
        title: title ?? this.title,
        type: type ?? this.type,
        widthCm: widthCm ?? this.widthCm,
        heightCm: heightCm ?? this.heightCm,
        widthInch: widthInch ?? this.widthInch,
        heightInch: heightInch ?? this.heightInch,
      );
}

class AlbumPage {
  final List<AlbumDecoration> decorations;
  final List<AlbumPhoto> photos;
  final AlbumPageBackground background;
  final AlbumPageLayout layout;

  AlbumPage({
    required this.decorations,
    required this.photos,
    required this.background,
    required this.layout,
  });
  factory AlbumPage.fromMap(Map<String, dynamic> data) => AlbumPage(
        decorations: data['decorations'].map((entry) => AlbumDecoration.fromMap(entry)).toList(),
        photos: data['photos'].map((entry) => AlbumPhoto.fromMap(entry)).toList(),
        background: AlbumPageBackground.fromMap(data['background']),
        layout: AlbumPageLayout.fromMap(data['layout']),
      );

  Map<String, dynamic> get toMap => {
        'decorations': this.decorations.map((e) => e.toMap).toList(),
        'photos': this.photos.map((e) => e.toMap).toList(),
        'background': this.background.toMap,
        'layout': this.layout.toMap,
      };
}

class AlbumPhoto {
  final String localPath;
  final double height, width, x, y;

  AlbumPhoto({
    required this.localPath,
    required this.height,
    required this.width,
    required this.x,
    required this.y,
  });

  factory AlbumPhoto.fromMap(Map<String, dynamic> data) => AlbumPhoto(
        localPath: data['local_path'],
        height: data['height'],
        width: data['width'],
        x: data['x'],
        y: data['y'],
      );

  Map<String, dynamic> get toMap => {
        'local_path': this.localPath,
        'height': this.height,
        'width': this.width,
        'x': this.x,
        'y': this.y,
      };
}

class AlbumPageLayout extends DownloadableContent {
  AlbumPageLayout({
    required String title,
    required String downloadLink,
    required String localPath,
  }) : super(title: title, downloadLink: downloadLink, localPath: localPath);

  factory AlbumPageLayout.fromMap(Map<String, dynamic> data) => AlbumPageLayout(
        title: data['title'],
        localPath: '',
        downloadLink: data['download_link'],
      );
}

class AlbumPageBackground extends DownloadableContent {
  AlbumPageBackground({
    required String title,
    required String downloadLink,
    required String localPath,
  }) : super(title: title, downloadLink: downloadLink, localPath: localPath);

  factory AlbumPageBackground.fromMap(Map<String, dynamic> data) => AlbumPageBackground(
        title: data['title'],
        localPath: '',
        downloadLink: data['download_link'],
      );
}

class AlbumCover extends DownloadableContent {
  AlbumCover({
    required String title,
    required String downloadLink,
    required String localPath,
  }) : super(title: title, downloadLink: downloadLink, localPath: localPath);

  factory AlbumCover.fromMap(Map<String, dynamic> data) => AlbumCover(
        title: data['title'],
        localPath: '',
        downloadLink: data['download_link'],
      );
}

class DownloadableContent {
  final String title;
  final String localPath;
  final String downloadLink;

  DownloadableContent({
    required this.title,
    required this.downloadLink,
    required this.localPath,
  });

  bool get isCached => localPath.isNotEmpty;

  as<T extends DownloadableContent>() {
    if (T is AlbumCover)
      return AlbumCover(title: title, downloadLink: downloadLink, localPath: localPath);
    else if (T is AlbumPageLayout)
      return AlbumPageLayout(title: title, downloadLink: downloadLink, localPath: localPath);
    else if (T is AlbumPageBackground) return AlbumPageBackground(title: title, downloadLink: downloadLink, localPath: localPath);
  }

  @override
  String toString() => this.toMap.toString();

  DownloadableContent copyWith({String? coverName, String? localPath, String? downloadLink}) => DownloadableContent(
        title: coverName ?? this.title,
        localPath: localPath ?? this.localPath,
        downloadLink: downloadLink ?? this.downloadLink,
      );

  Map<String, dynamic> get toMap => {
        'title': this.title,
        'local_path': this.localPath,
        'download_link': this.downloadLink,
      };
}
