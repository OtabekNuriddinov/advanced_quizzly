import 'package:advanced_quizzly/app.dart';
import '/app_state/change_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
        create: (_)=> AppProvider(),
      child: AdvancedQuiz(),
    ),
  );
}