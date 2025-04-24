import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final int option;
  final void Function() onPressed;
  const OptionsButton({
    required this.option,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(300, 60),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        "$option",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
