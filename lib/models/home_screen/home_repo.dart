import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../utils/constants.dart';

class HomeRepo {
  Future<String> submitReport(
      {required String fitnessLevel,
      required String fitnessGoal,
      required String workLimits}) async {
    String promptString = '''
      Current Fitness Level: $fitnessLevel

      Fitness Goals: 
        $fitnessGoal

      Fitness Workout Limitations: 
      $workLimits

      Describe all possible exercises which follow all above condition
    ''';
    debugPrint(promptString);
    var data = await Constants.model.generateContent(
      [
        Content.text(promptString),
      ],
    );
    Constants.sucessLog(data.text);
    return (data.text ?? '').replaceAll("*", "");
  }
}
