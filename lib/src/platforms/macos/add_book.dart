import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frinda/src/common/blocs/book_bloc.dart';
import 'package:frinda/src/common/cubits/books_cubit.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class AddBookButton extends StatelessWidget {

  const AddBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 20,
        height: 20,
        child:
      PushButton(controlSize: ControlSize.regular,
      child: Text("+"),
      onPressed: () async {
      final bookBloc = BookBloc();
      bookBloc.add(const LoadBookEvent());
      final booksCubit = context.read<BooksCubit>();
      booksCubit.addBook(bookBloc);
    },));
  }
}