import 'package:fitness_coach_app/models/home_screen/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';
import 'fitnessGoalCard.dart';
import 'fitness_goal_dm.dart';

// ignore: must_be_immutable
class FitnessGoals extends StatelessWidget {
  List<FitnessGoalDm> selectedGoalList;

  FitnessGoals({super.key, required this.selectedGoalList});

  List<FitnessGoalDm> fitnessGoalList = [
    FitnessGoalDm(
      title: "Improve your overall health",
      iconText: Constants.improveOverallHealth,
      desc:
          "This could include goals like losing weight, gaining muscle, or increasing your cardiovascular endurance. Getting regular exercise is one of the best things you can do for your overall health. It can help you control your weight, reduce your risk of chronic diseases, improve your mood, and boost your energy levels.",
      index: 0,
    ),
    FitnessGoalDm(
      iconText: Constants.specificEvent,
      title: "Train for a specific event",
      keyPoints: [
        KeyPoint(
          title: "Weight Loss Challenges",
        ),
        KeyPoint(
          title: "Strength Gain Challenges",
        ),
        KeyPoint(
          title: "Yoga Challenges",
        ),
        KeyPoint(
          title: "Mindfulness Challenges",
        ),
      ],
      index: 1,
    ),
    FitnessGoalDm(
      iconText: Constants.improveForParticularSport,
      title: "Improve your performance in a particular sport",
      keyPoints: [
        KeyPoint(
          title: "Basketball",
        ),
        KeyPoint(
          title: "Soccer",
        ),
        KeyPoint(
          title: "Volleyball",
        ),
        KeyPoint(
          title: "Baseball/Softball",
        ),
        KeyPoint(
          title: "Swimming",
        ),
        KeyPoint(
          title: "Running",
        ),
        KeyPoint(
          title: "Cycling",
        ),
        KeyPoint(
          title: "Chess",
        ),
        KeyPoint(title: "Rugby")
      ],
      index: 2,
    ),
    FitnessGoalDm(
      iconText: Constants.moreTonedPhysique,
      title: "Develop a more toned physique",
      keyPoints: [
        KeyPoint(
          title: "Resistance Training",
        ),
        KeyPoint(
          title: "Nutrition",
        ),
        KeyPoint(
          title: "Increasing cardiovascular endurance",
        ),
        KeyPoint(
          title: "Cardiovascular Exercise",
        ),
        KeyPoint(
          title: "Recovery",
        ),
        KeyPoint(
          title: "Consistency",
        )
      ],
      index: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (selectedGoalList.isNotEmpty) {
      int index = (selectedGoalList.first.index!);
      fitnessGoalList[index] = selectedGoalList.first;
    }
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
            fitnessGoalDm: fitnessGoalList[index],
            index: index,
            isSelected: selectedGoalList.isNotEmpty
                ? selectedGoalList.first.title == fitnessGoalList[index].title
                : false,
            onTap: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(SelectFitnessGoalEvent(fitnessGoalList[index]));
            },
          ),
      ],
    );
  }
}
