import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frinda/src/common/blocs/book_bloc.dart';

class BookShelf extends StatelessWidget {
  const BookShelf({Key? key, required this.state}) : super(key: key);
  final BookLoaded state;

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 4, children: [
      for (var book in state.books)
        GestureDetector(
            onTap: () {}, child: Image.file(File(book.cover ?? ''))),
      Text("123")
    ]);
  }
}
