import 'package:fitness_coach_app/models/home_screen/fitness_goal/fitness_goal_dm.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../utils/constants.dart';
import 'limitation_screen/limitation_dm.dart';

class HomeRepo {
  Future<String> submitReport(
      {required String fitnessLevel,
      required List<FitnessGoalDm> fitnessGoal,
      required List<LimitationListDm> workLimits}) async {
    String fitnessGoalStr = '';
    fitnessGoal.forEach((element) {
      String temp = fitnessGoalString(element);
      fitnessGoalStr = fitnessGoalStr + temp;
    });

    String limitationStr = '';
    workLimits.forEach((element) {
      if ((element.limitationList?.any((ele) => ele.isSelected == true) ??
          false)) {
        String temp = limitationString(element);
        limitationStr = limitationStr + temp;
      }
    });
    String promptString = '''
      Current Fitness Level: $fitnessLevel

      Fitness Goals: 
      $fitnessGoalStr

      Fitness Workout Limitations: 
      $limitationStr

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

String limitationString(LimitationListDm limitation) {
  String data = '''\t${limitation.title} : ''' + '\n';
  limitation.limitationList?.forEach((element) {
    data = data +
        '\t\t' +
        '''${element.title}
    ''';
  });
  return data;
}

String fitnessGoalString(FitnessGoalDm fitnessGoal) {
  String temp = '''\t${fitnessGoal.title}''';
  if (fitnessGoal.keyPoints != null &&
      fitnessGoal.keyPoints!.any((ele) => ele.isSelected == true)) {
    temp = "$temp : \n";
  }
  fitnessGoal.keyPoints?.forEach((element) {
    if (element.isSelected == true) {
      temp = temp +
          '\t\t' +
          '''${element.title},
      ''';
    }
  });
  return temp;
}
