import 'dart:math';

import 'package:advanced_quizzly/core/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AppProvider extends ChangeNotifier {
  final List<int> _amallar1 = [];
  List<int> get amallar1 => _amallar1;

  final List<int> _amallar2 = [];
  List<int> get amallar2 => _amallar2;

  final List<String> _selectedOperators = [];
  List<String> get selectedOperators => _selectedOperators;

  final List<String> _questionOperators = [];
  List<String> get questionOperators => _questionOperators;

  final List<List<int>> _options = [];
  List<List<int>> get options => _options;
  int correct = 0;
  int currentQuestionCount = 0;

  int currentQuestionIndex = 0;
  int currentOperatorIndex = 0;

  final AudioPlayer _audioPlayer = AudioPlayer();

  void generate(int start, int end, int limit) {
    if (_selectedOperators.isEmpty) return;

    _amallar1.clear();
    _amallar2.clear();
    _questionOperators.clear();
    _options.clear();

    Random random = Random();
    while (limit > 0) {
      int number1 = random.nextInt(end - start + 1) + start;
      int number2 = random.nextInt(end - start + 1) + start;

      int randIndex = random.nextInt(_selectedOperators.length);
      String randomOperator = _selectedOperators[randIndex];

      if(randomOperator == "/"){
        number2 = random.nextInt(end - start + 1) + start;
        while(number2==0){
          number2 = random.nextInt(end-start + 1) +start;
        }

        int multiplier = random.nextInt(5) + 1;
        number1 = number2 * multiplier;
      }

      int correctAnswer = calculate(number1, number2, randomOperator);

      Set<int> optionSet = {correctAnswer};
      while(optionSet.length<3){
        int randomOffset = random.nextInt(5)+1;
        int fakeAnswer = correctAnswer +(random.nextBool()?randomOffset:-randomOffset);
        optionSet.add(fakeAnswer);
      }

      List<int> optionList = optionSet.toList();
      optionList.shuffle();

      _amallar1.add(number1);
      _amallar2.add(number2);
      _options.add(optionList);
      _questionOperators.add(randomOperator);
      limit--;
    }
    notifyListeners();
  }

  void correctCount(int selectedAnswer){
    int amal1 = _amallar1[currentQuestionIndex];
    int amal2 = _amallar2[currentQuestionIndex];
    String operator = _questionOperators[currentQuestionIndex];

    int correctAnswer = calculate(amal1, amal2, operator);

    if(selectedAnswer==correctAnswer){
      correct++;
    }
    notifyListeners();
  }
  int calculate(int amal1, int amal2, String maths) {
    switch (maths) {
      case "/":
        if (amal2 == 0) return 0;
        return amal1 ~/ amal2;
      case "+":
        return amal1 + amal2;
      case "-":
        return amal1 - amal2;
      case "*":
        return amal1 * amal2;
      default:
        return 0;
    }
  }

  void addOperators(String op) {
    if (_selectedOperators.contains(op)) {
      _selectedOperators.remove(op);
    } else {
      _selectedOperators.add(op);
    }
    notifyListeners();
  }

  void nextQuestion(int index, BuildContext context) {
    final double percentage = (correct / questionOperators.length) * 100;
    if (index < _amallar1.length - 1) {
      currentQuestionIndex++;
      currentQuestionCount++;
      notifyListeners();
    } else {
      if(percentage>=70){
        playWin();
      }
      else{
        playLost();
      }
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.result,
        (route)=>false,
      );
    }
  }
  void playWin() async {
    try{
      await _audioPlayer.setAsset("assets/sounds/congrats.mp3");
      _audioPlayer.play();
    }
    catch(e){
      print("Error: $e");
    }
  }
  void playLost() async {
    try{
      await _audioPlayer.setAsset("assets/sounds/game_over.mp3");
      _audioPlayer.play();
    }
    catch(e){
      print("Error: $e");
    }
  }


  void playClick() async{
    try{
      await _audioPlayer.setAsset("assets/sounds/click.mp3");
      _audioPlayer.play();
    }
    catch(e){
      print("Error: $e");
    }
  }


  void resetGame(BuildContext context){
    _amallar1.clear();
    _amallar2.clear();
    _questionOperators.clear();
    _options.clear();
    currentQuestionIndex = 0;
    currentQuestionCount = 0;
    correct = 0;
    _selectedOperators.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
          (route) => false,
    );
    notifyListeners();
  }
}
