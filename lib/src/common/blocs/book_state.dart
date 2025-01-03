part of 'book_bloc.dart';
sealed class BookState extends Equatable {
  const BookState();

  Map<String, dynamic> toJson();
}
final class BookInitial extends BookState {
  @override
  List<Object> get props => [];
  const BookInitial();
  factory BookInitial.fromJson(Map<String, dynamic> json) {
    return BookInitial();
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
final class BookLoading extends BookState {

  const BookLoading(this.path);
  final String path;

  @override
  List<Object> get props => [path];
  factory BookLoading.fromJson(Map<String, dynamic> json) {
    return BookLoading(json['path']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'path': path};
  }
}
final class BookLoaded extends BookState {

  const BookLoaded(this.book);
  final Book book;


  @override
  List<Object> get props => [book.uuid];
  factory BookLoaded.fromJson(Map<String, dynamic> json) {
    return BookLoaded(Book(
      id: json['id'],
      uuid: json['uuid'],
      title: json['title'],
      author: json['author'],
      size: json['size'],
      format: json['format'],
      publishDate: json['publishDate'],
      path: json['path'],
      cover: json['cover']
    ));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': book.id,
      'uuid': book.uuid,
      'title': book.title,
      'author': book.author,
      'size': book.size,
      'format': book.format,
      'publishDate': book.publishDate,
      'path': book.path,
      'cover': book.cover
    };
  }
}
final class BookLoadFailed extends BookState {
  const BookLoadFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];

  factory BookLoadFailed.fromJson(Map<String, dynamic> json) {
    return BookLoadFailed(json['error']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'error': error};
  }
}