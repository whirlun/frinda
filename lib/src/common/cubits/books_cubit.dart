import 'package:bloc/bloc.dart';
import 'package:frinda/main.dart';
import 'package:frinda/src/common/blocs/book_bloc.dart';
import 'package:frinda/src/common/entities/book_entity.dart';

part 'books_state.dart';
class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksState([]));
  void addBook(BookBloc book) {
    final books = state.books;
    books.add(book);
    emit(BooksState(books));
  }

  void readBookFromDatabase() {
    final bookBox = objectBox.store.box<Book>();
    final books = bookBox.getAll();
    for (var book in books) {
      final bookBloc = BookBloc();
      bookBloc.add(RestoreJsonEvent(book.toJson()));
      addBook(bookBloc);
    }
  }

  void _restoreFromJson(BooksState state) {
    emit(state);
  }

  factory BooksCubit.fromJson(Map<String, dynamic> json) {
    final cubit = BooksCubit();
    cubit._restoreFromJson(BooksState.fromJson(json));
    return cubit;
  }

  Map<String, dynamic>? toJson(BooksState state) => {'state': state};
}
