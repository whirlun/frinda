// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/common/entities/book_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 4481251243663366763),
      name: 'Book',
      lastPropertyId: const obx_int.IdUid(9, 7200673917632479433),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 9061006949115717764),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5870460930225158806),
            name: 'uuid',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8505257763371058970),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 3893140265859450907),
            name: 'author',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 1321646925805154787),
            name: 'format',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 9077689149767909797),
            name: 'publishDate',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 7241611693866321929),
            name: 'path',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 7941279291066024540),
            name: 'cover',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 7200673917632479433),
            name: 'size',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 4481251243663366763),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Book: obx_int.EntityDefinition<Book>(
        model: _entities[0],
        toOneRelations: (Book object) => [],
        toManyRelations: (Book object) => {},
        getId: (Book object) => object.id,
        setId: (Book object, int id) {
          object.id = id;
        },
        objectToFB: (Book object, fb.Builder fbb) {
          final uuidOffset = fbb.writeString(object.uuid);
          final titleOffset = fbb.writeString(object.title);
          final authorOffset = fbb.writeString(object.author);
          final formatOffset = fbb.writeString(object.format);
          final publishDateOffset = fbb.writeString(object.publishDate);
          final pathOffset = fbb.writeString(object.path);
          final coverOffset =
              object.cover == null ? null : fbb.writeString(object.cover!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uuidOffset);
          fbb.addOffset(2, titleOffset);
          fbb.addOffset(3, authorOffset);
          fbb.addOffset(4, formatOffset);
          fbb.addOffset(5, publishDateOffset);
          fbb.addOffset(6, pathOffset);
          fbb.addOffset(7, coverOffset);
          fbb.addInt64(8, object.size);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final uuidParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final authorParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final sizeParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          final formatParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final publishDateParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, '');
          final pathParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final coverParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 18);
          final object = Book(
              id: idParam,
              uuid: uuidParam,
              title: titleParam,
              author: authorParam,
              size: sizeParam,
              format: formatParam,
              publishDate: publishDateParam,
              path: pathParam,
              cover: coverParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Book] entity fields to define ObjectBox queries.
class Book_ {
  /// See [Book.id].
  static final id = obx.QueryIntegerProperty<Book>(_entities[0].properties[0]);

  /// See [Book.uuid].
  static final uuid = obx.QueryStringProperty<Book>(_entities[0].properties[1]);

  /// See [Book.title].
  static final title =
      obx.QueryStringProperty<Book>(_entities[0].properties[2]);

  /// See [Book.author].
  static final author =
      obx.QueryStringProperty<Book>(_entities[0].properties[3]);

  /// See [Book.format].
  static final format =
      obx.QueryStringProperty<Book>(_entities[0].properties[4]);

  /// See [Book.publishDate].
  static final publishDate =
      obx.QueryStringProperty<Book>(_entities[0].properties[5]);

  /// See [Book.path].
  static final path = obx.QueryStringProperty<Book>(_entities[0].properties[6]);

  /// See [Book.cover].
  static final cover =
      obx.QueryStringProperty<Book>(_entities[0].properties[7]);

  /// See [Book.size].
  static final size =
      obx.QueryIntegerProperty<Book>(_entities[0].properties[8]);
}
