import 'package:fitness_coach_app/models/home_screen/fitness_goal/fitnessGoalCard.dart';
import 'package:fitness_coach_app/models/home_screen/limitation_screen/limitation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';
import '../fitess_level_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'limitation_dm.dart';

class Limitation extends StatefulWidget {
  const Limitation({super.key});

  @override
  State<Limitation> createState() => _LimitationState();
}

class _LimitationState extends State<Limitation> {
  LimitationBloc limitationBloc = LimitationBloc();

  /// physical limitation list
  List<LimitationDm> physicalLimitationList = [
    LimitationDm(
      title: "Injuries",
      desc:
          "Recent or past injuries may limit your ability to perform certain exercises or workouts. It's important to listen to your body and avoid exercises that cause pain.",
      index: 1,
    ),
    LimitationDm(
      title: "Chronic conditions",
      desc:
          "Certain health conditions, such as arthritis, heart disease, or asthma, may require modifications to your workout routine.",
      index: 2,
    ),
    LimitationDm(
      title: "Pregnancy",
      desc:
          "There are specific exercises that are recommended and not recommended during pregnancy. It's important to consult with your doctor before starting any new workout program.",
      index: 3,
    ),
    LimitationDm(
      title: "Age",
      desc:
          "As we age, our bodies become less flexible and may not be able to handle the same level of intensity as when we were younger.",
      index: 4,
    ),
  ];

  /// time limitation list
  List<LimitationDm> timeLimitationList = [
    LimitationDm(
      title: "Busy schedule",
      desc:
          "Many people find it difficult to fit in time for exercise with their busy schedules. However, even short bursts of activity can be beneficial.",
      index: 1,
    ),
  ];

  /// skill limitation list
  List<LimitationDm> skillLimitationList = [
    LimitationDm(
      title: "Beginner level",
      desc:
          "If you're new to exercise, you may need to start with a beginner-friendly program and gradually increase the difficulty as you get stronger and more fit.",
      index: 1,
    ),
  ];

  /// motivational limitation list
  List<LimitationDm> motivationalLimitationList = [
    LimitationDm(
      title: "Lack of motivation",
      desc:
          "It can be tough to stay motivated to exercise, especially if you don't see results immediately.",
      index: 1,
    ),
  ];

  @override
  void initState() {
    limitationBloc.stream.listen((state) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Fitness Workout Limitations",
          style: getIt<AppTextStyle>().mukta20pxSemoBold,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FitessLevelButton(
                  title: "Physical limitations",
                  isSelected: limitationBloc.state is PhysicalLimitState,
                  onTap: () {
                    limitationBloc.add(PhysicalLimitEvent());
                  }),
              const SizedBox(
                width: 15,
              ),
              FitessLevelButton(
                  title: "Time limitations",
                  isSelected: limitationBloc.state is TimeLimitState,
                  onTap: () {
                    limitationBloc.add(TimeLimitEvent());
                  }),
              const SizedBox(
                width: 15,
              ),
              FitessLevelButton(
                  title: "Skill limitations",
                  isSelected: limitationBloc.state is SkillLimitState,
                  onTap: () {
                    limitationBloc.add(SkillLimitEvent());
                  }),
              const SizedBox(
                width: 15,
              ),
              FitessLevelButton(
                  title: "Motivational limitations",
                  isSelected: limitationBloc.state is MotivationalLimitState,
                  onTap: () {
                    limitationBloc.add(MotivationalLimitEvent());
                  }),
            ],
          ),
        ),
        BlocBuilder(
            bloc: limitationBloc,
            builder: (context, state) {
              if (state is PhysicalLimitState) {
                return Column(
                  children: [
                    for (int index = 0;
                        index < physicalLimitationList.length;
                        index++)
                      Column(
                        children: [
                          limitCards(
                              title: physicalLimitationList[index].title ?? '',
                              desc: physicalLimitationList[index].desc ?? '',
                              onTap: () {}),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                  ],
                );
              }
              if (state is TimeLimitState) {
                return Column(
                  children: [
                    for (int index = 0;
                        index < timeLimitationList.length;
                        index++)
                      Column(
                        children: [
                          limitCards(
                              title: timeLimitationList[index].title ?? '',
                              desc: timeLimitationList[index].desc ?? '',
                              onTap: () {}),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                  ],
                );
              }
              if (state is SkillLimitState) {
                return Column(
                  children: [
                    for (int index = 0;
                        index < skillLimitationList.length;
                        index++)
                      Column(
                        children: [
                          limitCards(
                              title: skillLimitationList[index].title ?? '',
                              desc: skillLimitationList[index].desc ?? '',
                              onTap: () {}),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                  ],
                );
              }
              if (state is MotivationalLimitState) {
                return Column(
                  children: [
                    for (int index = 0;
                        index < motivationalLimitationList.length;
                        index++)
                      Column(
                        children: [
                          limitCards(
                              title:
                                  motivationalLimitationList[index].title ?? '',
                              desc:
                                  motivationalLimitationList[index].desc ?? '',
                              onTap: () {}),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                  ],
                );
              }
              return const Text("");
            })
      ],
    );
  }

  Widget limitCards(
      {required String title,
      required String desc,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: getIt<AppTextStyle>().mukta15pxbold,
            ),
            Text(
              desc,
              textAlign: TextAlign.start,
              style: getIt<AppTextStyle>().mukta13pxnormal,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            )
          ],
        ),
      ),
    );
  }
}
