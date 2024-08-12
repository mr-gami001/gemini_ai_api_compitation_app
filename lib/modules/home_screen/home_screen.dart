import 'package:fitness_coach_app/modules/app_landing/dependecy_inject.dart';
import 'package:fitness_coach_app/modules/home_screen/fitness_goal/fitness_goals.dart';
import 'package:fitness_coach_app/modules/home_screen/home_bloc.dart';
import 'package:fitness_coach_app/modules/home_screen/limitation_screen/limitation.dart';
import 'package:fitness_coach_app/modules/home_screen/limitation_screen/limitation_dm.dart';
import 'package:fitness_coach_app/modules/result_screen/result_screen.dart';
import 'package:fitness_coach_app/utils/constants.dart';
import 'package:fitness_coach_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat_screen/chat_screen.dart';
import 'fitess_level_button.dart';
import 'fitness_goal/fitness_goal_dm.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: Text(
          "Fitness Coach AI",
          style: getIt<AppTextStyle>().mukta25pxSemoBold,
        ),
      ),
      body: BlocProvider<HomeBloc>(
        create: (context) => homeBloc,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: BlocConsumer(
              bloc: homeBloc,
              builder: (context, state) {
                if (state is SucessState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      fitnessLevel(state.selectedLevel),
                      const SizedBox(
                        height: 20,
                      ),
                      fitnessGoals(state.selectedLevel, state.fitnessGoalsList),
                      if (Constants.currentLevel.value.isNotEmpty)
                        const SizedBox(
                          height: 20,
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state.fitnessGoalsList.isNotEmpty)
                        limitation(state.selectedLimitationList),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state.selectedLevel.isNotEmpty &&
                          state.fitnessGoalsList.isNotEmpty)
                        submitBtn(state),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              listener: (context, state) async {
                if (state is TransmitState) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultScreen(reslutText: state.reslutText),
                    ),
                  );
                  homeBloc.add(InitEvent());
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen()));
          showDialog(context: context, builder: (context) => ChatScreen());
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget submitBtn(HomeBlocState state) {
    if (state is SucessState && state.isSubmitLoading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>((shape) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        onPressed: () {
          homeBloc.add(SubmitEvent());
        },
        child: Text(
          "Submit",
          style: getIt<AppTextStyle>().mukta15pxboldBlack,
        ),
      ),
    );
  }

  Widget limitation(List<LimitationListDm> selectedLimitationList) {
    if (selectedLimitationList.isNotEmpty) {
      return Limitation(
        selectedLimitation: selectedLimitationList.first,
      );
    }
    return Limitation();
  }

  Widget fitnessGoals(String selectedText, List<FitnessGoalDm> goalCheckList) {
    if (selectedText.isNotEmpty) {
      return FitnessGoals(
        selectedGoalList: goalCheckList,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget fitnessLevel(String selectedText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Current Fitness Level",
          style: getIt<AppTextStyle>().mukta20pxSemoBold,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FitessLevelButton(
                  title: "Beginner",
                  isSelected: selectedText == "Beginner",
                  onTap: () {
                    homeBloc.add(SelectLevelEvent("Beginner"));
                  }),
              const SizedBox(
                width: 15,
              ),
              FitessLevelButton(
                  title: "Intermediate",
                  isSelected: selectedText == "Intermediate",
                  onTap: () {
                    homeBloc.add(SelectLevelEvent("Intermediate"));
                  }),
              const SizedBox(
                width: 15,
              ),
              FitessLevelButton(
                  title: "Advanced Exerciser",
                  isSelected: selectedText == "Advanced Exerciser",
                  onTap: () {
                    homeBloc.add(SelectLevelEvent("Advanced Exerciser"));
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
