// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Album extends DataClass implements Insertable<Album> {
  final String title;
  final String type;
  final double widthCm;
  final double heightCm;
  final double widthInch;
  final double heightInch;
  final String cover;
  final String pages;
  final String timeStamp;
  Album(
      {required this.title,
      required this.type,
      required this.widthCm,
      required this.heightCm,
      required this.widthInch,
      required this.heightInch,
      required this.cover,
      required this.pages,
      required this.timeStamp});
  factory Album.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Album(
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
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
      timeStamp: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_stamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['width_cm'] = Variable<double>(widthCm);
    map['height_cm'] = Variable<double>(heightCm);
    map['width_inch'] = Variable<double>(widthInch);
    map['height_inch'] = Variable<double>(heightInch);
    map['cover'] = Variable<String>(cover);
    map['pages'] = Variable<String>(pages);
    map['time_stamp'] = Variable<String>(timeStamp);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      title: Value(title),
      type: Value(type),
      widthCm: Value(widthCm),
      heightCm: Value(heightCm),
      widthInch: Value(widthInch),
      heightInch: Value(heightInch),
      cover: Value(cover),
      pages: Value(pages),
      timeStamp: Value(timeStamp),
    );
  }

  factory Album.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Album(
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      widthCm: serializer.fromJson<double>(json['widthCm']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      widthInch: serializer.fromJson<double>(json['widthInch']),
      heightInch: serializer.fromJson<double>(json['heightInch']),
      cover: serializer.fromJson<String>(json['cover']),
      pages: serializer.fromJson<String>(json['pages']),
      timeStamp: serializer.fromJson<String>(json['timeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'widthCm': serializer.toJson<double>(widthCm),
      'heightCm': serializer.toJson<double>(heightCm),
      'widthInch': serializer.toJson<double>(widthInch),
      'heightInch': serializer.toJson<double>(heightInch),
      'cover': serializer.toJson<String>(cover),
      'pages': serializer.toJson<String>(pages),
      'timeStamp': serializer.toJson<String>(timeStamp),
    };
  }

  Album copyWith(
          {String? title,
          String? type,
          double? widthCm,
          double? heightCm,
          double? widthInch,
          double? heightInch,
          String? cover,
          String? pages,
          String? timeStamp}) =>
      Album(
        title: title ?? this.title,
        type: type ?? this.type,
        widthCm: widthCm ?? this.widthCm,
        heightCm: heightCm ?? this.heightCm,
        widthInch: widthInch ?? this.widthInch,
        heightInch: heightInch ?? this.heightInch,
        cover: cover ?? this.cover,
        pages: pages ?? this.pages,
        timeStamp: timeStamp ?? this.timeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('widthCm: $widthCm, ')
          ..write('heightCm: $heightCm, ')
          ..write('widthInch: $widthInch, ')
          ..write('heightInch: $heightInch, ')
          ..write('cover: $cover, ')
          ..write('pages: $pages, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, type, widthCm, heightCm, widthInch,
      heightInch, cover, pages, timeStamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.title == this.title &&
          other.type == this.type &&
          other.widthCm == this.widthCm &&
          other.heightCm == this.heightCm &&
          other.widthInch == this.widthInch &&
          other.heightInch == this.heightInch &&
          other.cover == this.cover &&
          other.pages == this.pages &&
          other.timeStamp == this.timeStamp);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<String> title;
  final Value<String> type;
  final Value<double> widthCm;
  final Value<double> heightCm;
  final Value<double> widthInch;
  final Value<double> heightInch;
  final Value<String> cover;
  final Value<String> pages;
  final Value<String> timeStamp;
  const AlbumsCompanion({
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.widthCm = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.widthInch = const Value.absent(),
    this.heightInch = const Value.absent(),
    this.cover = const Value.absent(),
    this.pages = const Value.absent(),
    this.timeStamp = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required String title,
    required String type,
    required double widthCm,
    required double heightCm,
    required double widthInch,
    required double heightInch,
    required String cover,
    required String pages,
    required String timeStamp,
  })  : title = Value(title),
        type = Value(type),
        widthCm = Value(widthCm),
        heightCm = Value(heightCm),
        widthInch = Value(widthInch),
        heightInch = Value(heightInch),
        cover = Value(cover),
        pages = Value(pages),
        timeStamp = Value(timeStamp);
  static Insertable<Album> custom({
    Expression<String>? title,
    Expression<String>? type,
    Expression<double>? widthCm,
    Expression<double>? heightCm,
    Expression<double>? widthInch,
    Expression<double>? heightInch,
    Expression<String>? cover,
    Expression<String>? pages,
    Expression<String>? timeStamp,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (widthCm != null) 'width_cm': widthCm,
      if (heightCm != null) 'height_cm': heightCm,
      if (widthInch != null) 'width_inch': widthInch,
      if (heightInch != null) 'height_inch': heightInch,
      if (cover != null) 'cover': cover,
      if (pages != null) 'pages': pages,
      if (timeStamp != null) 'time_stamp': timeStamp,
    });
  }

  AlbumsCompanion copyWith(
      {Value<String>? title,
      Value<String>? type,
      Value<double>? widthCm,
      Value<double>? heightCm,
      Value<double>? widthInch,
      Value<double>? heightInch,
      Value<String>? cover,
      Value<String>? pages,
      Value<String>? timeStamp}) {
    return AlbumsCompanion(
      title: title ?? this.title,
      type: type ?? this.type,
      widthCm: widthCm ?? this.widthCm,
      heightCm: heightCm ?? this.heightCm,
      widthInch: widthInch ?? this.widthInch,
      heightInch: heightInch ?? this.heightInch,
      cover: cover ?? this.cover,
      pages: pages ?? this.pages,
      timeStamp: timeStamp ?? this.timeStamp,
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
    if (timeStamp.present) {
      map['time_stamp'] = Variable<String>(timeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('widthCm: $widthCm, ')
          ..write('heightCm: $heightCm, ')
          ..write('widthInch: $widthInch, ')
          ..write('heightInch: $heightInch, ')
          ..write('cover: $cover, ')
          ..write('pages: $pages, ')
          ..write('timeStamp: $timeStamp')
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
  final VerificationMeta _timeStampMeta = const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<String?> timeStamp = GeneratedColumn<String?>(
      'time_stamp', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        title,
        type,
        widthCm,
        heightCm,
        widthInch,
        heightInch,
        cover,
        pages,
        timeStamp
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
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
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

class DecorationElement extends DataClass
    implements Insertable<DecorationElement> {
  final String downloadLink;
  final String title;
  final String localPath;
  final double height;
  final double width;
  DecorationElement(
      {required this.downloadLink,
      required this.title,
      required this.localPath,
      required this.height,
      required this.width});
  factory DecorationElement.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DecorationElement(
      downloadLink: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}download_link'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      localPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_path'])!,
      height: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}height'])!,
      width: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}width'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['download_link'] = Variable<String>(downloadLink);
    map['title'] = Variable<String>(title);
    map['local_path'] = Variable<String>(localPath);
    map['height'] = Variable<double>(height);
    map['width'] = Variable<double>(width);
    return map;
  }

  DecorationElementsCompanion toCompanion(bool nullToAbsent) {
    return DecorationElementsCompanion(
      downloadLink: Value(downloadLink),
      title: Value(title),
      localPath: Value(localPath),
      height: Value(height),
      width: Value(width),
    );
  }

  factory DecorationElement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DecorationElement(
      downloadLink: serializer.fromJson<String>(json['downloadLink']),
      title: serializer.fromJson<String>(json['title']),
      localPath: serializer.fromJson<String>(json['localPath']),
      height: serializer.fromJson<double>(json['height']),
      width: serializer.fromJson<double>(json['width']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'downloadLink': serializer.toJson<String>(downloadLink),
      'title': serializer.toJson<String>(title),
      'localPath': serializer.toJson<String>(localPath),
      'height': serializer.toJson<double>(height),
      'width': serializer.toJson<double>(width),
    };
  }

  DecorationElement copyWith(
          {String? downloadLink,
          String? title,
          String? localPath,
          double? height,
          double? width}) =>
      DecorationElement(
        downloadLink: downloadLink ?? this.downloadLink,
        title: title ?? this.title,
        localPath: localPath ?? this.localPath,
        height: height ?? this.height,
        width: width ?? this.width,
      );
  @override
  String toString() {
    return (StringBuffer('DecorationElement(')
          ..write('downloadLink: $downloadLink, ')
          ..write('title: $title, ')
          ..write('localPath: $localPath, ')
          ..write('height: $height, ')
          ..write('width: $width')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(downloadLink, title, localPath, height, width);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DecorationElement &&
          other.downloadLink == this.downloadLink &&
          other.title == this.title &&
          other.localPath == this.localPath &&
          other.height == this.height &&
          other.width == this.width);
}

class DecorationElementsCompanion extends UpdateCompanion<DecorationElement> {
  final Value<String> downloadLink;
  final Value<String> title;
  final Value<String> localPath;
  final Value<double> height;
  final Value<double> width;
  const DecorationElementsCompanion({
    this.downloadLink = const Value.absent(),
    this.title = const Value.absent(),
    this.localPath = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
  });
  DecorationElementsCompanion.insert({
    required String downloadLink,
    required String title,
    required String localPath,
    required double height,
    required double width,
  })  : downloadLink = Value(downloadLink),
        title = Value(title),
        localPath = Value(localPath),
        height = Value(height),
        width = Value(width);
  static Insertable<DecorationElement> custom({
    Expression<String>? downloadLink,
    Expression<String>? title,
    Expression<String>? localPath,
    Expression<double>? height,
    Expression<double>? width,
  }) {
    return RawValuesInsertable({
      if (downloadLink != null) 'download_link': downloadLink,
      if (title != null) 'title': title,
      if (localPath != null) 'local_path': localPath,
      if (height != null) 'height': height,
      if (width != null) 'width': width,
    });
  }

  DecorationElementsCompanion copyWith(
      {Value<String>? downloadLink,
      Value<String>? title,
      Value<String>? localPath,
      Value<double>? height,
      Value<double>? width}) {
    return DecorationElementsCompanion(
      downloadLink: downloadLink ?? this.downloadLink,
      title: title ?? this.title,
      localPath: localPath ?? this.localPath,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (downloadLink.present) {
      map['download_link'] = Variable<String>(downloadLink.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecorationElementsCompanion(')
          ..write('downloadLink: $downloadLink, ')
          ..write('title: $title, ')
          ..write('localPath: $localPath, ')
          ..write('height: $height, ')
          ..write('width: $width')
          ..write(')'))
        .toString();
  }
}

class $DecorationElementsTable extends DecorationElements
    with TableInfo<$DecorationElementsTable, DecorationElement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecorationElementsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _downloadLinkMeta =
      const VerificationMeta('downloadLink');
  @override
  late final GeneratedColumn<String?> downloadLink = GeneratedColumn<String?>(
      'download_link', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _localPathMeta = const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String?> localPath = GeneratedColumn<String?>(
      'local_path', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double?> height = GeneratedColumn<double?>(
      'height', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double?> width = GeneratedColumn<double?>(
      'width', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [downloadLink, title, localPath, height, width];
  @override
  String get aliasedName => _alias ?? 'decoration_elements';
  @override
  String get actualTableName => 'decoration_elements';
  @override
  VerificationContext validateIntegrity(Insertable<DecorationElement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('download_link')) {
      context.handle(
          _downloadLinkMeta,
          downloadLink.isAcceptableOrUnknown(
              data['download_link']!, _downloadLinkMeta));
    } else if (isInserting) {
      context.missing(_downloadLinkMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DecorationElement map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DecorationElement.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DecorationElementsTable createAlias(String alias) {
    return $DecorationElementsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $DecorationElementsTable decorationElements =
      $DecorationElementsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [albums, decorationElements];
}
