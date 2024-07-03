import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  String selectedLevel = '';
  List<String> fitnessGoalsList = [];

  HomeBloc() : super(SucessState("", [])) {
    on<SelectLevelEvent>((event, emit) {
      selectedLevel = event.selectedLevel;
      emit(SucessState(selectedLevel, fitnessGoalsList));
    });
    on<SelectFitnessGoalEvent>((event, emit) {
      if (fitnessGoalsList.contains(event.selectedGoal)) {
        fitnessGoalsList.remove(event.selectedGoal);
      } else {
        fitnessGoalsList.add(event.selectedGoal);
      }
      emit(SucessState(selectedLevel, fitnessGoalsList));
    });
  }
}

abstract class HomeBlocEvent {}

class SelectLevelEvent extends HomeBlocEvent {
  String selectedLevel;

  SelectLevelEvent(this.selectedLevel);
}

class SelectFitnessGoalEvent extends HomeBlocEvent {
  String selectedGoal;

  SelectFitnessGoalEvent(this.selectedGoal);
}

abstract class HomeBlocState {}

class InitState extends HomeBlocState {}

class SucessState extends HomeBlocState {
  String selectedLevel;
  List<String> fitnessGoalsList = [];

  SucessState(this.selectedLevel, this.fitnessGoalsList);
}
