import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Uri uri = Uri(
      scheme: "https",
      host: "gravatar.com",
      path: "/avatar/e944138e1114aefe4b08848a46465589");
  MemoryImage? img;
  await http.get(uri).then((response) {
    print(response.toString());
    img = MemoryImage(response.bodyBytes);
  });

  ui.Picture pic = await memoryImageToPicture(img!.bytes);

  saveImage(pic);

  print("Foo");
}

Future<ui.Picture> memoryImageToPicture(Uint8List imageData) async {
  final ui.Image image = await decodeImageFromList(imageData);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawImage(image, Offset.zero, Paint());
  return recorder.endRecording();
}

Future<void> saveImage(ui.Picture pic) async {
  ui.Image image = await pic.toImage(200, 200);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  if (byteData != null) {
    final file = File('image1234.png'); // Replace with your desired file path
    await file.writeAsBytes(byteData.buffer.asUint8List());
  }
}
