import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Albums extends Table {
  TextColumn get title => text()();
  TextColumn get type => text()();
  RealColumn get widthCm => real()();
  RealColumn get heightCm => real()();
  RealColumn get widthInch => real()();
  RealColumn get heightInch => real()();
  TextColumn get cover => text()();
  TextColumn get pages => text()();
}

class DecorationElements extends Table {
  TextColumn get downloadLink => text()();
  TextColumn get title => text()();
  TextColumn get localPath => text()();
  RealColumn get height => real()();
  RealColumn get width => real()();
}

@UseMoor(tables: [Albums, DecorationElements])
class AppDatabase extends _$AppDatabase {
  static AppDatabase instance = AppDatabase._();

  AppDatabase._() : super(FlutterQueryExecutor.inDatabaseFolder(path: "album.sqlite", logStatements: true));
  int get schemaVersion => 1;

  Future<List<Album>> getAllAlbums() => select(albums).get();
  Future insertAlbum(Album album) => into(albums).insert(album);
  Future deleteAlbum(Album album) => delete(albums).delete(album);
  Stream<List<Album>> get localAlbumStream => select(albums).watch();

  // Future<List<DecorationElement>> hasDecorationElementWithLink(String link) => select(decorationElements)
  //   ..where((tbl) => tbl.downloadLink.equals(link))
  //   ..get();
}
