import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frinda/src/platforms/ios/ios_view.dart';
import 'package:frinda/src/platforms/macos/macos_view.dart';
import 'package:frinda/src/rust/frb_generated.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'objectbox.g.dart';

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig(
    toolbarStyle: NSWindowToolbarStyle.unified,
  );
  await config.apply();
}

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  objectBox = await ObjectBox.create();
  switch (Platform.operatingSystem) {
    case 'macos':
      await _configureMacosWindowUtils();
      runApp(const MacosView());
      break;
    case 'ios':
      runApp(const IosView());
    default:
      runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Center(
          child: Text('Action'),
        ),
      ),
    );
  }
}

class ObjectBox {
  late final Store store;
  ObjectBox._create(this.store);
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationSupportDirectory();
    print(p.join(docsDir.path, "frinda_store"));
    final store = await openStore(directory: p.join(docsDir.path, "frinda_store"), macosApplicationGroup: "frinda");
    return ObjectBox._create(store);
}
}