import 'package:flutter/material.dart';

import 'image_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Информация об изображениях'),
        ),
        body: ImageList(),
      ),
    );
  }
}
