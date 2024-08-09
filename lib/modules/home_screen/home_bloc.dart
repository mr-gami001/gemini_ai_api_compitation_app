import 'package:fitness_coach_app/modules/app_landing/dependecy_inject.dart';
import 'package:fitness_coach_app/modules/home_screen/home_repo.dart';
import 'package:fitness_coach_app/modules/home_screen/limitation_screen/limitation_dm.dart';
import 'package:fitness_coach_app/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fitness_goal/fitness_goal_dm.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  String selectedLevel = '';
  List<FitnessGoalDm> selectedFitnessGoal = [];
  List<LimitationListDm> selectedLimitation = [];
  bool isSubmitLoading = false;

  HomeBloc() : super(SucessState("", [], [], true)) {
    on<InitEvent>((event, emit) {
      isSubmitLoading = false;
      selectedLevel = '';
      selectedFitnessGoal = [];
      selectedLimitation = [];
      emit(
        SucessState(selectedLevel, selectedFitnessGoal, selectedLimitation,
            isSubmitLoading),
      );
    });

    on<SelectLevelEvent>((event, emit) {
      selectedLevel = event.selectedLevel;
      emit(
        SucessState(selectedLevel, selectedFitnessGoal, selectedLimitation,
            isSubmitLoading),
      );
    });
    on<SelectFitnessGoalEvent>((event, emit) {
      selectedFitnessGoal = [event.limitationDm];
      emit(
        SucessState(selectedLevel, selectedFitnessGoal, selectedLimitation,
            isSubmitLoading),
      );
    });

    on<SelectLimitationHomeEvent>((event, emit) {
      if (event.limitationDm != null) {
        selectedLimitation = event.limitationDm!;
      }
      emit(
        SucessState(selectedLevel, selectedFitnessGoal, selectedLimitation,
            isSubmitLoading),
      );
    });

    ///on Tap of submit button
    on<SubmitEvent>((event, emit) async {
      try {
        isSubmitLoading = true;
        emit(
          SucessState(selectedLevel, selectedFitnessGoal, selectedLimitation,
              isSubmitLoading),
        );

        String res = await getIt<HomeRepo>().submitReport(
            fitnessLevel: selectedLevel,
            fitnessGoal: selectedFitnessGoal,
            workLimits: selectedLimitation);
        emit(TransmitState(res.toString()));
      } catch (e) {
        Constants.errorLog(e);
        isSubmitLoading = false;
        emit(
          SucessState(selectedLevel, selectedFitnessGoal, selectedLimitation,
              isSubmitLoading),
        );
      }
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

class SelectLimitationHomeEvent extends HomeBlocEvent {
  List<LimitationListDm>? limitationDm;

  SelectLimitationHomeEvent(this.limitationDm);
}

class SubmitEvent extends HomeBlocEvent {}

class InitEvent extends HomeBlocEvent {}

abstract class HomeBlocState {}

class InitState extends HomeBlocState {}

class TransmitState extends HomeBlocState {
  String reslutText;
  TransmitState(this.reslutText);
}

class SucessState extends HomeBlocState {
  String selectedLevel;
  List<FitnessGoalDm> fitnessGoalsList;
  List<LimitationListDm> selectedLimitationList;
  bool isSubmitLoading;

  SucessState(this.selectedLevel, this.fitnessGoalsList,
      this.selectedLimitationList, this.isSubmitLoading);
}
