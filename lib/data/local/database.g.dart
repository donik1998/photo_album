// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Album extends DataClass implements Insertable<Album> {
  final String title;
  final String type;
  final String thumbnailPath;
  final double widthCm;
  final double heightCm;
  final double widthInch;
  final double heightInch;
  final String cover;
  final String pages;
  Album(
      {required this.title,
      required this.type,
      required this.thumbnailPath,
      required this.widthCm,
      required this.heightCm,
      required this.widthInch,
      required this.heightInch,
      required this.cover,
      required this.pages});
  factory Album.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Album(
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      thumbnailPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_path'])!,
      widthCm: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}width_cm'])!,
      heightCm: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}height_cm'])!,
      widthInch: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}width_inch'])!,
      heightInch: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}height_inch'])!,
      cover: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover'])!,
      pages: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pages'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['thumbnail_path'] = Variable<String>(thumbnailPath);
    map['width_cm'] = Variable<double>(widthCm);
    map['height_cm'] = Variable<double>(heightCm);
    map['width_inch'] = Variable<double>(widthInch);
    map['height_inch'] = Variable<double>(heightInch);
    map['cover'] = Variable<String>(cover);
    map['pages'] = Variable<String>(pages);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      title: Value(title),
      type: Value(type),
      thumbnailPath: Value(thumbnailPath),
      widthCm: Value(widthCm),
      heightCm: Value(heightCm),
      widthInch: Value(widthInch),
      heightInch: Value(heightInch),
      cover: Value(cover),
      pages: Value(pages),
    );
  }

  factory Album.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Album(
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      thumbnailPath: serializer.fromJson<String>(json['thumbnailPath']),
      widthCm: serializer.fromJson<double>(json['widthCm']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      widthInch: serializer.fromJson<double>(json['widthInch']),
      heightInch: serializer.fromJson<double>(json['heightInch']),
      cover: serializer.fromJson<String>(json['cover']),
      pages: serializer.fromJson<String>(json['pages']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'thumbnailPath': serializer.toJson<String>(thumbnailPath),
      'widthCm': serializer.toJson<double>(widthCm),
      'heightCm': serializer.toJson<double>(heightCm),
      'widthInch': serializer.toJson<double>(widthInch),
      'heightInch': serializer.toJson<double>(heightInch),
      'cover': serializer.toJson<String>(cover),
      'pages': serializer.toJson<String>(pages),
    };
  }

  Album copyWith(
          {String? title,
          String? type,
          String? thumbnailPath,
          double? widthCm,
          double? heightCm,
          double? widthInch,
          double? heightInch,
          String? cover,
          String? pages}) =>
      Album(
        title: title ?? this.title,
        type: type ?? this.type,
        thumbnailPath: thumbnailPath ?? this.thumbnailPath,
        widthCm: widthCm ?? this.widthCm,
        heightCm: heightCm ?? this.heightCm,
        widthInch: widthInch ?? this.widthInch,
        heightInch: heightInch ?? this.heightInch,
        cover: cover ?? this.cover,
        pages: pages ?? this.pages,
      );
  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('widthCm: $widthCm, ')
          ..write('heightCm: $heightCm, ')
          ..write('widthInch: $widthInch, ')
          ..write('heightInch: $heightInch, ')
          ..write('cover: $cover, ')
          ..write('pages: $pages')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, type, thumbnailPath, widthCm, heightCm,
      widthInch, heightInch, cover, pages);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.title == this.title &&
          other.type == this.type &&
          other.thumbnailPath == this.thumbnailPath &&
          other.widthCm == this.widthCm &&
          other.heightCm == this.heightCm &&
          other.widthInch == this.widthInch &&
          other.heightInch == this.heightInch &&
          other.cover == this.cover &&
          other.pages == this.pages);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<String> title;
  final Value<String> type;
  final Value<String> thumbnailPath;
  final Value<double> widthCm;
  final Value<double> heightCm;
  final Value<double> widthInch;
  final Value<double> heightInch;
  final Value<String> cover;
  final Value<String> pages;
  const AlbumsCompanion({
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.widthCm = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.widthInch = const Value.absent(),
    this.heightInch = const Value.absent(),
    this.cover = const Value.absent(),
    this.pages = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required String title,
    required String type,
    required String thumbnailPath,
    required double widthCm,
    required double heightCm,
    required double widthInch,
    required double heightInch,
    required String cover,
    required String pages,
  })  : title = Value(title),
        type = Value(type),
        thumbnailPath = Value(thumbnailPath),
        widthCm = Value(widthCm),
        heightCm = Value(heightCm),
        widthInch = Value(widthInch),
        heightInch = Value(heightInch),
        cover = Value(cover),
        pages = Value(pages);
  static Insertable<Album> custom({
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? thumbnailPath,
    Expression<double>? widthCm,
    Expression<double>? heightCm,
    Expression<double>? widthInch,
    Expression<double>? heightInch,
    Expression<String>? cover,
    Expression<String>? pages,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (widthCm != null) 'width_cm': widthCm,
      if (heightCm != null) 'height_cm': heightCm,
      if (widthInch != null) 'width_inch': widthInch,
      if (heightInch != null) 'height_inch': heightInch,
      if (cover != null) 'cover': cover,
      if (pages != null) 'pages': pages,
    });
  }

  AlbumsCompanion copyWith(
      {Value<String>? title,
      Value<String>? type,
      Value<String>? thumbnailPath,
      Value<double>? widthCm,
      Value<double>? heightCm,
      Value<double>? widthInch,
      Value<double>? heightInch,
      Value<String>? cover,
      Value<String>? pages}) {
    return AlbumsCompanion(
      title: title ?? this.title,
      type: type ?? this.type,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      widthCm: widthCm ?? this.widthCm,
      heightCm: heightCm ?? this.heightCm,
      widthInch: widthInch ?? this.widthInch,
      heightInch: heightInch ?? this.heightInch,
      cover: cover ?? this.cover,
      pages: pages ?? this.pages,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (widthCm.present) {
      map['width_cm'] = Variable<double>(widthCm.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (widthInch.present) {
      map['width_inch'] = Variable<double>(widthInch.value);
    }
    if (heightInch.present) {
      map['height_inch'] = Variable<double>(heightInch.value);
    }
    if (cover.present) {
      map['cover'] = Variable<String>(cover.value);
    }
    if (pages.present) {
      map['pages'] = Variable<String>(pages.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('widthCm: $widthCm, ')
          ..write('heightCm: $heightCm, ')
          ..write('widthInch: $widthInch, ')
          ..write('heightInch: $heightInch, ')
          ..write('cover: $cover, ')
          ..write('pages: $pages')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _thumbnailPathMeta =
      const VerificationMeta('thumbnailPath');
  @override
  late final GeneratedColumn<String?> thumbnailPath = GeneratedColumn<String?>(
      'thumbnail_path', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _widthCmMeta = const VerificationMeta('widthCm');
  @override
  late final GeneratedColumn<double?> widthCm = GeneratedColumn<double?>(
      'width_cm', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _heightCmMeta = const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double?> heightCm = GeneratedColumn<double?>(
      'height_cm', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _widthInchMeta = const VerificationMeta('widthInch');
  @override
  late final GeneratedColumn<double?> widthInch = GeneratedColumn<double?>(
      'width_inch', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _heightInchMeta = const VerificationMeta('heightInch');
  @override
  late final GeneratedColumn<double?> heightInch = GeneratedColumn<double?>(
      'height_inch', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _coverMeta = const VerificationMeta('cover');
  @override
  late final GeneratedColumn<String?> cover = GeneratedColumn<String?>(
      'cover', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pagesMeta = const VerificationMeta('pages');
  @override
  late final GeneratedColumn<String?> pages = GeneratedColumn<String?>(
      'pages', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        title,
        type,
        thumbnailPath,
        widthCm,
        heightCm,
        widthInch,
        heightInch,
        cover,
        pages
      ];
  @override
  String get aliasedName => _alias ?? 'albums';
  @override
  String get actualTableName => 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<Album> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
          _thumbnailPathMeta,
          thumbnailPath.isAcceptableOrUnknown(
              data['thumbnail_path']!, _thumbnailPathMeta));
    } else if (isInserting) {
      context.missing(_thumbnailPathMeta);
    }
    if (data.containsKey('width_cm')) {
      context.handle(_widthCmMeta,
          widthCm.isAcceptableOrUnknown(data['width_cm']!, _widthCmMeta));
    } else if (isInserting) {
      context.missing(_widthCmMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('width_inch')) {
      context.handle(_widthInchMeta,
          widthInch.isAcceptableOrUnknown(data['width_inch']!, _widthInchMeta));
    } else if (isInserting) {
      context.missing(_widthInchMeta);
    }
    if (data.containsKey('height_inch')) {
      context.handle(
          _heightInchMeta,
          heightInch.isAcceptableOrUnknown(
              data['height_inch']!, _heightInchMeta));
    } else if (isInserting) {
      context.missing(_heightInchMeta);
    }
    if (data.containsKey('cover')) {
      context.handle(
          _coverMeta, cover.isAcceptableOrUnknown(data['cover']!, _coverMeta));
    } else if (isInserting) {
      context.missing(_coverMeta);
    }
    if (data.containsKey('pages')) {
      context.handle(
          _pagesMeta, pages.isAcceptableOrUnknown(data['pages']!, _pagesMeta));
    } else if (isInserting) {
      context.missing(_pagesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Album.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AlbumsTable albums = $AlbumsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [albums];
}
