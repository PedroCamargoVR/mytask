import 'package:flutter/material.dart';

class InputAddTask extends StatelessWidget {
  final String _hintText;
  final int _maxLines;
  final int? _maxLength;
  final TextEditingController _controller = TextEditingController();

  InputAddTask({Key? key,required hintText, required maxLines, maxLength}) : _hintText = hintText, _maxLines = maxLines, _maxLength = maxLength, super(key: key);

  TextEditingController getController(){
    return _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6,bottom: 6),
      child: TextFormField(
        controller: _controller,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black87),
          ),
          hintText: _hintText,
        ),
        maxLines: _maxLines,
        maxLength: _maxLength,
      ),
    );
  }
}
