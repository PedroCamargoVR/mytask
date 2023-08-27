import 'package:flutter/material.dart';

class LineSeparator extends StatelessWidget {
  const LineSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 0, right: 0, bottom: 8.0, top: 8.0),
      child: Container(
        height: 1,
        decoration:
        BoxDecoration(border: Border.all(color: Colors.grey)),
      ),
    );
  }
}
