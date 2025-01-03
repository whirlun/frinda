import 'package:flutter/material.dart';
import 'package:frinda/src/common/blocs/book_bloc.dart';
import 'package:frinda/src/common/cubits/books_cubit.dart';
import 'package:frinda/src/platforms/macos/add_book.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MacosView extends StatelessWidget {
  const MacosView({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp(
        theme: MacosThemeData.light(),
        darkTheme: MacosThemeData.dark(),
        home: BlocProvider(create: (_) {
          final cubit = BooksCubit();
          cubit.readBookFromDatabase();
          return cubit;
        }, child: const MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      backgroundColor: Color(0xFFFFFFFF),
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: _pageIndex,
            onChanged: (index) {
              setState(() => _pageIndex = index);
            },
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                label: Text('Home'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.search),
                label: Text('Explore'),
              ),
            ],
          );
        },
      ),
      child: IndexedStack(
        index: _pageIndex,
        children: [
          MacosScaffold(
            children: [
              ContentArea(
                builder: ((context, scrollController) {
                  return BlocBuilder<BooksCubit, BooksState>(builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AddBookButton(),
                        Text('Books: ${state.books.length}'),
                        for (var b in state.books.where((b) => b.state is BookLoaded)) Text((b.state as BookLoaded).book.title),
                      ],
                    );
                  });
                }),
              ),
            ],
          ),
          MacosScaffold(
            children: [
              ContentArea(
                builder: ((context, scrollController) {
                  return const Center(
                    child: Text('Explore'),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
