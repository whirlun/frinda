import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:epubx/epubx.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frinda/main.dart';
import 'package:frinda/src/common/entities/book_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:dart_mobi/dart_mobi.dart';
part 'book_event.dart';
part 'book_state.dart';
class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<LoadBookEvent>(_loadBook);
    on<RestoreJsonEvent>(_restoreFromJson);
    on<RestoreDatabaseEvent>(_restoreFromDatabase);
  }

  void _loadBook(event, emit) async {
    print(state.runtimeType);
    if (state is! BookLoaded) {
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final storageDir = await getApplicationDocumentsDirectory();
      final copied = await file.copy("${storageDir.path}/${p.basename(file.path)}");
      if (p.extension(file.path) == ".epub") {
        final bytes = file.readAsBytes();
        EpubBook epubBook = await EpubReader.readBook(bytes);
        EpubPackage? package = epubBook.Schema?.Package;
        final uuid = Uuid().v4();
        String? coverPath;
        if (epubBook.CoverImage != null) {
          Image image = epubBook.CoverImage!;

          final cover = File(p.join(storageDir.path, "$uuid.jpg"));
          await cover.writeAsBytes(image.data);
          coverPath = cover.path;
        }
        final bookBox = objectBox.store.box<Book>();
        final book = Book(
            uuid: uuid,
            title: epubBook.Title ?? "",
            author: epubBook.Author ?? "",
            size: file.lengthSync(),
            format: "epub",
            publishDate: package?.Metadata?.Dates?.first.Date ?? "",
            path: copied.path,
            cover: coverPath);
        bookBox.put(book);
        emit(BookLoaded((state as BookLoaded).books + [book]));
      } else if ([".mobi", ".azw", ".azw3", ".pdb", ".prc", ".azw4"].contains(p.extension(file.path))) {
        final bytes = await file.readAsBytes();
        final mobiData = await DartMobiReader.read(bytes);
        final rawml = mobiData.parseOpt(true, true, true);
        String title = mobiData.mobiHeader?.fullname ?? "";
        String? author;
        String? publishDate;
        int? coverOffset;
        var cur = mobiData.mobiExthHeader;
        while (cur != null) {
          if (cur.tag == 503) {
            title = utf8.decode(cur.data ?? []);
          } else if (cur.tag == 100) {
            author = utf8.decode(cur.data ?? []);
          } else if (cur.tag == 106) {
            publishDate = utf8.decode(cur.data ?? []);
          } else if (cur.tag == 201) {
            coverOffset = cur.data![0] << 24 | cur.data![1] << 16 | cur.data![2] << 8 | cur.data![3];
          }
          cur = cur.next;
        }
        final firstImageIndex = mobiData.mobiHeader?.imageIndex ?? 0;
        final uuid = Uuid().v4();
        File? cover;

        MobiPart? resource = rawml.resources;
        var i = 0;
        while (resource != null) {
          if (i == coverOffset) {
            cover = File(p.join(storageDir.path, "covers", "$uuid.jpg"));
            await cover.writeAsBytes(resource.data!);
            break;
          }
          i++;
          resource = resource.next;
        }

        final bookBox = objectBox.store.box<Book>();
        final book = Book(
            uuid: uuid,
            title: title,
            author: author ?? "",
            size: file.lengthSync(),
            format: p.extension(file.path).substring(1),
            publishDate: publishDate ?? "",
            path: copied.path,
            cover: cover?.path
        );
        await bookBox.putAsync(book);
        emit(BookLoaded((state as BookLoaded).books + [book]));
      }
    }
  }

  void _restoreFromDatabase(event, emit) async {
    final bookBox = objectBox.store.box<Book>();
    final books = bookBox.getAll();
    emit(BookLoaded([]));
    for (var b in books) {
      emit(BookLoaded((state as BookLoaded).books + [b]));
    }
  }

  void _restoreFromJson(event, emit) {
    switch (event.bookJson['type']) {
      case "BookInitial":
        emit(BookInitial());
        return;
      case "BookLoaded":
        emit(BookLoaded([]));
        for (var b in event.bookJson['state']) {
          emit(BookLoaded((state as BookLoaded).books + [Book.fromJson(b)]));
        }
        return;
      case "BookLoadFailed":
        emit(BookLoadFailed(event.bookJson['error']));
        return;
      default:
        throw Exception("Unknown state type");
    }
  }

  factory BookBloc.fromJson(Map<String, dynamic> json) {
    final bloc = BookBloc();
    bloc.add(RestoreJsonEvent(json));
    return bloc;
  }

  Map<String, dynamic> toJson() {
    return state.toJson();
  }
}
