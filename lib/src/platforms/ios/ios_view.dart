import 'package:flutter/cupertino.dart';

class IosView extends StatelessWidget {
  const IosView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('flutter_rust_bridge quickstart'),
        ),
        child: Center(
          child: Text('Action'),
        ),
      ),
    );
  }
}
