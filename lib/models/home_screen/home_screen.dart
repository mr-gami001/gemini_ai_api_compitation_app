import 'package:fitness_coach_app/models/app_landing/dependecy_inject.dart';
import 'package:fitness_coach_app/models/home_screen/fitness_goal/fitness_goals.dart';
import 'package:fitness_coach_app/models/home_screen/home_bloc.dart';
import 'package:fitness_coach_app/models/home_screen/limitation_screen/limitation.dart';
import 'package:fitness_coach_app/utils/constants.dart';
import 'package:fitness_coach_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

import '../chat_screen/chat_screen.dart';
import 'fitess_level_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: const Text("Fitness Coach AI"),
      ),
      body: BlocProvider<HomeBloc>(
        create: (context) => homeBloc,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: BlocBuilder(
              bloc: homeBloc,
              builder: (context,state) {
               if(state is SucessState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        fitnessLevel(state.selectedLevel),
                        const SizedBox(
                          height: 20,
                        ),
                        fitnessGoals(state.selectedLevel,state.fitnessGoalsList),
                        if (Constants.currentLevel.value.isNotEmpty)
                          const SizedBox(
                            height: 20,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        if(state.fitnessGoalsList.isNotEmpty)limitation()
                      ],
                    );
                  }return const  Center(child: CircularProgressIndicator(),);
                }
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

  Widget limitation() {
    return Limitation();
  }

  Widget fitnessGoals(String selectedText,List<String> goalCheckList) {

        if (selectedText.isNotEmpty) {
          return FitnessGoals(selectedGoalList: goalCheckList,);
        } else {
          return SizedBox();
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
