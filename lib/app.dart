import 'package:advanced_quizzly/core/config/routes.dart';
import 'package:flutter/material.dart';

class AdvancedQuiz extends StatelessWidget {
  const AdvancedQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}
