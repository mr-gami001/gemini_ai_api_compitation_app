import 'package:fitness_coach_app/models/home_screen/limitation_screen/limitation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';
import '../fitess_level_button.dart';
import 'limitation_dm.dart';

// ignore: must_be_immutable
class Limitation extends StatefulWidget {
  LimitationListDm? selectedLimitation;
  Limitation({super.key, this.selectedLimitation});

  @override
  State<Limitation> createState() => _LimitationState();
}

class _LimitationState extends State<Limitation> {
  late LimitationBloc limitationBloc;
  int currentLimitationIndex = 0;

  List<LimitationListDm> limitationlist = [
    LimitationListDm(title: 'Physical limitations', index: 0, limitationList: [
      LimitationDm(
        title: "Injuries",
        desc:
            "Recent or past injuries may limit your ability to perform certain exercises or workouts. It's important to listen to your body and avoid exercises that cause pain.",
        index: 0,
      ),
      LimitationDm(
        title: "Chronic conditions",
        desc:
            "Certain health conditions, such as arthritis, heart disease, or asthma, may require modifications to your workout routine.",
        index: 1,
      ),
      LimitationDm(
        title: "Pregnancy",
        desc:
            "There are specific exercises that are recommended and not recommended during pregnancy. It's important to consult with your doctor before starting any new workout program.",
        index: 2,
      ),
      LimitationDm(
        title: "Age",
        desc:
            "As we age, our bodies become less flexible and may not be able to handle the same level of intensity as when we were younger.",
        index: 3,
      ),
    ]),
    LimitationListDm(index: 1, title: 'Time limitations', limitationList: [
      LimitationDm(
        title: "Busy schedule",
        desc:
            "Many people find it difficult to fit in time for exercise with their busy schedules. However, even short bursts of activity can be beneficial.",
        index: 0,
      ),
    ]),
    LimitationListDm(index: 2, title: 'Skill limitations', limitationList: [
      LimitationDm(
        title: "Beginner level",
        desc:
            "If you're new to exercise, you may need to start with a beginner-friendly program and gradually increase the difficulty as you get stronger and more fit.",
        index: 0,
      ),
    ]),
    LimitationListDm(
        index: 3,
        title: 'Motivational limitations',
        limitationList: [
          LimitationDm(
            title: "Lack of motivation",
            desc:
                "It can be tough to stay motivated to exercise, especially if you don't see results immediately.",
            index: 0,
          ),
        ]),
  ];

  @override
  void initState() {
    limitationBloc = LimitationBloc(context);
    limitationBloc.add(
      SelectLimitationEvent(
          currentIndex: 0,
          limitationListDm: limitationlist[0],
          isSelected: false),
    );
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
        BlocBuilder(
          bloc: limitationBloc,
          builder: (context, state) {
            if (state is LimitationScessState) {
              return itemRow(limitation: state.limitationListDm);
            }
            return itemRow();
          },
        ),
      ],
    );
  }

  Widget itemRow({LimitationListDm? limitation}) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int index = 0; index < limitationlist.length; index++)
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: FitessLevelButton(
                      title: "Physical limitations",
                      isSelected: index == currentLimitationIndex,
                      onTap: () {
                        setState(() {
                          currentLimitationIndex = index;
                        });
                        limitationBloc.add(SelectLimitationEvent(
                            currentIndex: index,
                            limitationListDm: limitationlist[index]));
                      }),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        for (int index = 0;
            index <
                limitationlist[currentLimitationIndex].limitationList!.length;
            index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: limitCards(
                item: limitationlist[currentLimitationIndex]
                    .limitationList![index],
                onTap: () {
                  limitationBloc.add(
                    SelectLimitationItemEvent(
                        limitationDm: limitationlist[currentLimitationIndex]
                            .limitationList![index],
                        currentIndex: currentLimitationIndex),
                  );
                }),
          )
      ],
    );
  }

  Widget limitCards({required LimitationDm item, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title!,
                      textAlign: TextAlign.start,
                      style: getIt<AppTextStyle>().mukta15pxbold,
                    ),
                    Text(
                      item.desc!,
                      textAlign: TextAlign.start,
                      style: getIt<AppTextStyle>().mukta13pxnormal,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  ],
                ),
              ),
              Checkbox(
                  value: item.isSelected ?? false,
                  onChanged: (val) {
                    onTap.call();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
