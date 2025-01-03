part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();
}

final class LoadBookEvent extends BookEvent {
  const LoadBookEvent();

  @override
  List<Object> get props => [];
}

final class RestoreJsonEvent extends BookEvent {
  const RestoreJsonEvent(this.bookJson);
  final Map<String, dynamic> bookJson;

  @override
  List<Object> get props => [bookJson['id']];
}
