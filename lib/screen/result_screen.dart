import 'package:advanced_quizzly/app_state/change_notifier.dart';
import 'package:advanced_quizzly/core/components/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../core/config/routes.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final double percentage =
        (provider.correct / provider.questionOperators.length) * 100;
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "RESULT",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Align(
            alignment: Alignment(0, -0.8),
            child: SizedBox(
              width: 300,
              height: 200,
              child: (percentage >= 90)
                  ? Lottie.asset("assets/animation/well_anim.json")
                  : (percentage < 90 && percentage >= 70)
                      ? Lottie.asset("assets/animation/not_bad_anim.json")
                      : Lottie.asset(
                          "assets/animation/bad_anim.json",
                        ),
            ),
        ),
        Align(
          alignment: Alignment(0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your correct answers:",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "${provider.correct}/${provider.questionOperators.length}",
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                "Score: ${percentage.toStringAsFixed(1)}%",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: 280,
                child: MyElevatedButton(
                  text: "New Game",
                  onPressed: () {
                    provider.resetGame(context);
                  },
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
