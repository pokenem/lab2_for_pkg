import 'package:flutter/material.dart';

bool flag = true;
class tileInfo extends StatelessWidget {
  final String s1;
  final String s2;

  const tileInfo({Key? key, required this.s1, required this.s2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    flag = !flag;
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      tileColor: flag ? Colors.cyan : Colors.blueGrey,
      title: Text(s1,style:
        TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),),
      trailing: Text(s2,style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500
      ),),
    );
  }
}
