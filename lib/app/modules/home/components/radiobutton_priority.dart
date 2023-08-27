import 'package:flutter/material.dart';

class RadioButtonPriority extends StatefulWidget {
  String? radioValue;
  RadioButtonPriority({Key? key, this.radioValue = "baixa"}) : super(key: key);

  @override
  State<RadioButtonPriority> createState() => _RadioButtonPriorityState();

  String? getValue(){
    return radioValue;
  }
}

class _RadioButtonPriorityState extends State<RadioButtonPriority> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Radio(
            value: "baixa",
            groupValue: widget.radioValue,
            onChanged: (_) {
              setState(() {
                widget.radioValue = _.toString();
              });
            }),
        const Text("Baixa"),
        Radio(
            value: "media",
            groupValue: widget.radioValue,
            onChanged: (_) {
              setState(() {
                widget.radioValue = _.toString();
              });
            }),
        const Text("Média",style: TextStyle(color: Colors.orange),),
        Radio(
            value: "alta",
            groupValue: widget.radioValue,
            onChanged: (_) {
              setState(() {
                widget.radioValue = _.toString();
              });
            }),
        const Text("Alta",style: TextStyle(color: Colors.red),),
      ],
    );
  }
}
