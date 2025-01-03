import 'package:objectbox/objectbox.dart';

@Entity()
class Book {
  Book({this.id = 0,
    required this.uuid,
    required this.title,
    required this.author,
    required this.size,
    required this.format,
    required this.publishDate,
    required this.path,
    required this.cover});
  int id = 0;
  String uuid;
  String title;
  String author;
  int size;
  String format;
  String publishDate;
  String path;
  String? cover;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'title': title,
      'author': author,
      'size': size,
      'format': format,
      'publishDate': publishDate,
      'path': path,
      'cover': cover
    };
  }
}