import 'dart:convert';
import 'dart:io';
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
  }

  void _loadBook(event, emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      emit(BookLoading(result.files.single.path!));
      File file = File(result.files.single.path!);
      final storageDir = await getApplicationDocumentsDirectory();
      final copied = await file.copy("${storageDir.path}/${p.basename(file.path)}");

      if (p.extension(file.path) == "epub") {
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
        emit(BookLoaded(book));
      } else if (p.extension(file.path) == "mobi") {
        final bytes = await file.readAsBytes();
        final mobiData = await DartMobiReader.read(bytes);
        String title = mobiData.mobiHeader?.fullname ?? "";
        String? author;
        String? publishDate;
        var cur = mobiData.mobiExthHeader;
        while (cur != null) {
          if (cur.tag == 503) {
            title = utf8.decode(cur.data ?? []);
          } else if (cur.tag == 100) {
            author = utf8.decode(cur.data ?? []);
          } else if (cur.tag == 106) {
            publishDate = utf8.decode(cur.data ?? []);
          }
          cur = cur.next;
        }
        final uuid = Uuid().v4();
        final bookBox = objectBox.store.box<Book>();
        final book = Book(
            uuid: uuid,
            title: title,
            author: author ?? "",
            size: file.lengthSync(),
            format: "mobi",
            publishDate: publishDate ?? "",
            path: copied.path,
            cover: null
        );
        bookBox.put(book);
        emit(BookLoaded(book));
      }
    }
  }

  void _restoreFromJson(event, emit) async {
    emit(BookLoaded.fromJson(event.bookJson));
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
