import 'package:flutter/material.dart';
import 'package:frinda/src/common/blocs/book_bloc.dart';
import 'package:frinda/src/platforms/macos/add_book.dart';
import 'package:frinda/src/platforms/macos/book_shelf.dart';
import 'package:frinda/src/platforms/macos/text_reader.dart';
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
        home: BlocProvider(
            create: (_) {
              final bloc = BookBloc();
              bloc.add(const RestoreDatabaseEvent());
              return bloc;
            },
            child: const MyHomePage()));
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
            items: [
              //SidebarItem(label: Text("Library"), selectedColor: Color.fromARGB(1, 255, 255, 255)),
              const SidebarItem(
                  label: Text(
                    "Library",
                    style: TextStyle(color: Color.fromARGB(255, 162, 170, 173)),
                  ),
                  leading: null,
                  section: true,
                  disclosureItems: [
                    SidebarItem(
                        leading: MacosIcon(CupertinoIcons.home),
                        label: Text("Home")),
                  ]),
              const SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                label: Text('Home'),
              ),
              const SidebarItem(
                  label: Text(
                    "Actions",
                    style: TextStyle(color: Color.fromARGB(255, 162, 170, 173)),
                  ),
                  section: true),
              const SidebarItem(
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
                  return BlocBuilder<BookBloc, BookState>(
                      builder: (context, state) {
                    if (state is BookLoaded) {
                      return BookShelf(state: state);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
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
          TextReader(),
        ],
      ),
    );
  }
}
