import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frinda/src/platforms/ios/ios_view.dart';
import 'package:frinda/src/platforms/macos/macos_view.dart';
import 'package:frinda/src/rust/frb_generated.dart';
import 'package:macos_ui/macos_ui.dart';

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig(
    toolbarStyle: NSWindowToolbarStyle.unified,
  );
  await config.apply();
}

Future<void> main() async {
  await RustLib.init();
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
