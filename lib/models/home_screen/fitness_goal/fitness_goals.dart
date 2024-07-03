import 'package:fitness_coach_app/models/home_screen/home_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants.dart';
import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';
import 'fitnessGoalCard.dart';
import '../limitation_screen/limitation_dm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FitnessGoals extends StatelessWidget {
  List<String> selectedGoalList;

  FitnessGoals({super.key, required this.selectedGoalList});

  List<LimitationDm> fitnessGoalList = [
    LimitationDm(
        title: "Improve your overall health",
        iconText: Constants.improveOverallHealth,
        desc:
            "This could include goals like losing weight, gaining muscle, or increasing your cardiovascular endurance. Getting regular exercise is one of the best things you can do for your overall health. It can help you control your weight, reduce your risk of chronic diseases, improve your mood, and boost your energy levels.",
        index: 1),
    LimitationDm(
      iconText: Constants.specificEvent,
      title: "Train for a specific event",
      desc:
          "This could include goals like losing weight, gaining muscle, or increasing your cardiovascular endurance. Getting regular exercise is one of the best things you can do for your overall health. It can help you control your weight, reduce your risk of chronic diseases, improve your mood, and boost your energy levels.",
      index: 2,
    ),
    LimitationDm(
      iconText: Constants.improveForParticularSport,
      title: "Improve your performance in a particular sport",
      desc:
          "This could include goals like losing weight, gaining muscle, or increasing your cardiovascular endurance. Getting regular exercise is one of the best things you can do for your overall health. It can help you control your weight, reduce your risk of chronic diseases, improve your mood, and boost your energy levels.",
      index: 3,
    ),
    LimitationDm(
      iconText: Constants.moreTonedPhysique,
      title: "Develop a more toned physique",
      desc:
          "This could include goals like losing weight, gaining muscle, or increasing your cardiovascular endurance. Getting regular exercise is one of the best things you can do for your overall health. It can help you control your weight, reduce your risk of chronic diseases, improve your mood, and boost your energy levels.",
      index: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Fitness Goals",
          style: getIt<AppTextStyle>().mukta20pxSemoBold,
        ),
        for (int index = 0; index < fitnessGoalList.length; index++)
          Fitnessgoalcard(
            title: fitnessGoalList[index].title ?? '',
            desc: fitnessGoalList[index].desc ?? '',
            iconText: fitnessGoalList[index].iconText ?? "",
            isSelected: selectedGoalList.contains(fitnessGoalList[index].title),
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(
                  SelectFitnessGoalEvent(fitnessGoalList[index].title ?? ''));
            },
          ),
      ],
    );
  }
}
