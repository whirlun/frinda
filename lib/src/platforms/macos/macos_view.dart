import 'package:flutter/material.dart';
import 'package:frinda/src/common/blocs/book_bloc.dart';
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
          final bloc = BookBloc();
          bloc.add(const RestoreDatabaseEvent());
          return bloc;
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
                  return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AddBookButton(),
                        Text('Books: ${state is BookLoaded ? state.books.length : 0}'),
                        if (state is BookLoaded) for(var book in state.books) Text(book.title),
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
