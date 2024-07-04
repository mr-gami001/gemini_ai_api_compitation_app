import 'package:fitness_coach_app/models/app_landing/dependecy_inject.dart';
import 'package:fitness_coach_app/utils/text_style.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  String reslutText;
  ResultScreen({super.key, required this.reslutText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: const Text("Fitness Coach AI"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.white30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  reslutText,
                  style: getIt<AppTextStyle>().mukta15pxnormalBlack,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
