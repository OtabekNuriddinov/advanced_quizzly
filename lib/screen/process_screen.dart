import '../core/components/options_button.dart';
import '/app_state/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "PROCESS",
          style: TextStyle(fontSize: 30, color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<AppProvider>(builder: (context, generator, __) {
          int currentIndex = generator.currentQuestionIndex;
          String currentOperator = generator.questionOperators[currentIndex];
          List<int> options = generator.options[currentIndex];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Question: ${generator.currentQuestionCount + 1}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "${generator.amallar1[currentIndex]} $currentOperator ${generator.amallar2[currentIndex]} = ?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ...options.map((option) {
                return Column(
                  children: [
                    OptionsButton(
                      option: option,
                      onPressed: () {
                        generator.playClick();
                        generator.correctCount(option);
                        generator.nextQuestion(currentIndex, context);
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                );
              })
            ],
          );
        }),
      ),
    );
  }
}

