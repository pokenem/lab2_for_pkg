import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:untitled2/image_info.dart';
import 'package:untitled2/widgets/tile_info.dart';

class InfoPage extends StatefulWidget {
  final Imageinfo info;
  InfoPage({Key? key, required this.info}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late Uint8List bytes;
  late img.Image image;
  bool flag = false;

  @override
  void initState() {
    super.initState();
    // Инициализация переменной bytes здесь, до ее использования в блоке build
    widget.info.file.readAsBytes().then((value) {
      setState(() {
        bytes = value;
        image = img.decodeImage(Uint8List.fromList(bytes.toList()))!;
        flag = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return flag
        ? Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          tileInfo(s1: 'Name', s2: widget.info.file.name.toString()),
          tileInfo(s1: 'Size', s2: bytes.length.toString()),
          tileInfo(s1: 'Width', s2: image.width.toString()),
          tileInfo(s1: 'Height', s2: image.height.toString()),
          tileInfo(
              s1: 'Filter Quality',
              s2: Image.memory(bytes).filterQuality.toString()),
          tileInfo(
              s1: 'Bits per channel',
              s2: image.bitsPerChannel.toString()),
          tileInfo(s1: 'NumberOfChannels', s2: image.numChannels.toString()),
          tileInfo(s1: 'Compression', s2: ((image.width * image.height * image.numChannels) / bytes.length).toString()),
          for (dynamic it in widget.info.exif.entries)
            tileInfo(s1: it.key, s2: it.value.toString()),
        ],
      ),
    )
        : CircularProgressIndicator();
  }
}
