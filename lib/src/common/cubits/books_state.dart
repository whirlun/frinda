part of 'books_cubit.dart';
class BooksState {
  BooksState(this.books);
  List<BookBloc> books = [];
  factory BooksState.fromJson(Map<String, dynamic> json) {
    return BooksState(json['books']);
  }
  Map<String, dynamic> toJson() {
    return {'books': books};
  }
}
