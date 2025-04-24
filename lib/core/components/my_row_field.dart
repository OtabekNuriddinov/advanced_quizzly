import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyRowField extends StatelessWidget {
  const MyRowField({super.key, required this.controller, required this.text});

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        SizedBox(width: 30),
        SizedBox(
          width: 100,
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 2
                ),
              ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )
                ),
                border: UnderlineInputBorder()),
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white,),
          ),
        ),
      ],
    );
  }
}
