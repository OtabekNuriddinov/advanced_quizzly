import '/screen/home_screen.dart';
import '/screen/process_screen.dart';
import '/screen/result_screen.dart';
import 'package:flutter/material.dart';

sealed class AppRoutes{
  static const home = '/';
  static const process = "process";
  static const result = "result";

  static Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    home: (context) => HomeScreen(),
    process: (context) => ProcessScreen(),
    result: (context) => ResultScreen()
  };
}