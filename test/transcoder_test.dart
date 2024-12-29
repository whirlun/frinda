import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frinda/src/libs/transcoder.dart';
import 'package:logging/logging.dart';

void main() async {
  test("Transcoder functions", () async {
    WidgetsFlutterBinding.ensureInitialized();
    final tempDir = "/tmp";
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    final log = Logger("TranscoderTest");
    Process p = await transcode(
        "/Users/bbrabbit/Documents/whispertest/audio.m4b",
        tempDir,
        2432.940000,
        4684.021000);
    log.info("Process: ${p.pid}");
    final exists = await File("$tempDir/output.wav").exists();
    expect(exists, true);
  });
}
