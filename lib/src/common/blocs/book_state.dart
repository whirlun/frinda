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
    return {'type': 'BookInitial'};
  }
}

final class BookLoaded extends BookState {

  const BookLoaded(this.books);
  final List<Book> books;


  @override
  List<Object> get props => [books];
  factory BookLoaded.fromJson(Map<String, dynamic> json) {
    return BookLoaded(json['state'].map((e) => Book.fromJson(e)).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'BookLoaded', 'state': books.map((e) => e.toJson()).toList()};
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
    return {'type': 'BookLoadFailed', 'error': error};
  }
}