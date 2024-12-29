import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'dart:io';

Future<Process> transcode(
    String audioPath, String outputDir, num from, num to) async {
  final chapter = await Ffprobe.readChapter(audioPath);
  final command = FfmpegCommand.simple(
    inputs: [FfmpegInput.asset(audioPath)],
    args: [
      CliArg(name: "ss", value: from.toString()),
      CliArg(name: "to", value: to.toString()),
      CliArg(name: "acodec", value: "pcm_s16le"),
      CliArg(name: "ar", value: "16000"),
    ],
    outputFilepath: "$outputDir/output.wav",
  );
  return await Ffmpeg().run(command);
}
