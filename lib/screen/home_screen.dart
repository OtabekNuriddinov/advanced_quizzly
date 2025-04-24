import 'package:advanced_quizzly/app_state/change_notifier.dart';
import 'package:advanced_quizzly/core/components/my_elevated_button.dart';
import 'package:advanced_quizzly/core/components/my_row_field.dart';
import 'package:advanced_quizzly/core/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/my_maths.dart';
import '../core/utils/app_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController startController;
  late TextEditingController endController;
  late TextEditingController limitController;

  @override
  void initState() {
    super.initState();
    startController = TextEditingController();
    endController = TextEditingController();
    limitController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "QUIZZLY",
          style: TextStyle(fontSize: 30, color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<AppProvider>(builder: (context, generator, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              MyRowField(
                controller: startController,
                text: "Start",
              ),
              SizedBox(height: 30),
              MyRowField(
                controller: endController,
                text: "End",
              ),
              SizedBox(height: 30),
              MyRowField(
                controller: limitController,
                text: "limit",
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMaths(
                    amal: "+",
                    onPressed: () {
                      generator.addOperators("+");
                    },
                    isSelected: generator.selectedOperators.contains("+"),
                  ),
                  MyMaths(
                    amal: "-",
                    onPressed: () {
                      generator.addOperators("-");
                    },
                    isSelected: generator.selectedOperators.contains("-"),
                  ),
                  MyMaths(
                    amal: "*",
                    onPressed: () {
                      generator.addOperators("*");
                    },
                    isSelected: generator.selectedOperators.contains("*"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMaths(
                    amal: "/",
                    onPressed: () {
                      generator.addOperators("/");
                    },
                    isSelected: generator.selectedOperators.contains("/"),
                  ),
                  MyMaths(
                    amal: "",
                    onPressed: () {},
                  ),
                  MyMaths(
                    amal: "",
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                height: 60,
                child: MyElevatedButton(
                  text: "Train",
                  onPressed: () {
                    final startText = startController.text;
                    final endText = endController.text;
                    final limitText = limitController.text;
                    if (startText.isEmpty ||
                        endText.isEmpty ||
                        limitText.isEmpty) {
                      AppSnackBar.msg(
                          context, "Iltimos barcha maydonlarni to'ldiring!");
                      return;
                    }
                    if (generator.selectedOperators.isEmpty) {
                      AppSnackBar.msg(
                          context, "Iltimos Kamida bitta operator tanlang!");
                      return;
                    }
                    final start = int.parse(startText);
                    final end = int.parse(endText);
                    final limit = int.parse(limitText);
                    if (start >= end) {
                      AppSnackBar.msg(
                          context, "Start end dan kichkina bo'lishi kerak");
                      return;
                    }
                    generator.generate(start, end, limit);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.process,
                      (route) => false,
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
