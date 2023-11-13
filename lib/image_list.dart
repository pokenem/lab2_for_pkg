import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/widgets/tile_info.dart';

import 'image_info.dart';
import 'info_page.dart';

bool flag = true;

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  List<Imageinfo> imageInfoList = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();

    print('fdsfsf');
    for (dynamic it in pickedFile) {
      final exifFile = await readExifFromBytes(await it!.readAsBytes());
      for (dynamic it in exifFile.entries) {
        print(it);
      }

      final imageInfo = Imageinfo(exif: exifFile, file: it);
      _onImageInfoAdded(imageInfo);
    }
  }

  void _onImageInfoAdded(Imageinfo imageInfo) {
    setState(() {
      imageInfoList.add(imageInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: 200,
          height: 70,
          child: ElevatedButton(
            onPressed: _pickImage,
            child: Text('Выбрать изображение'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: imageInfoList.length,
            itemBuilder: (context, index) {
              flag = !flag;
              return Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => InfoPage(info: imageInfoList[index]),
                        ),
                      );
                    },
                    tileColor: flag ? Colors.cyan : Colors.blueGrey,
                    title: Text(
                      imageInfoList[index].file.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
