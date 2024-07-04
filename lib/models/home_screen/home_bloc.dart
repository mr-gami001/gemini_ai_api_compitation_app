import 'package:flutter_bloc/flutter_bloc.dart';

import 'fitness_goal/fitness_goal_dm.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  String selectedLevel = '';
  List<FitnessGoalDm> selectedLimitation = [];

  HomeBloc() : super(SucessState("", [])) {
    on<SelectLevelEvent>((event, emit) {
      selectedLevel = event.selectedLevel;
      emit(SucessState(selectedLevel, selectedLimitation));
    });
    on<SelectFitnessGoalEvent>((event, emit) {
      selectedLimitation = [event.limitationDm];
      emit(SucessState(selectedLevel, selectedLimitation));
    });
  }
}

abstract class HomeBlocEvent {}

class SelectLevelEvent extends HomeBlocEvent {
  String selectedLevel;

  SelectLevelEvent(this.selectedLevel);
}

class SelectFitnessGoalEvent extends HomeBlocEvent {
  FitnessGoalDm limitationDm;

  SelectFitnessGoalEvent(this.limitationDm);
}

abstract class HomeBlocState {}

class InitState extends HomeBlocState {}

class SucessState extends HomeBlocState {
  String selectedLevel;
  List<FitnessGoalDm> fitnessGoalsList;

  SucessState(this.selectedLevel, this.fitnessGoalsList);
}
