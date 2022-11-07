import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:30,
      color: Colors.blue,
      child: Center(child: Text('hello')),
    );
  }
}