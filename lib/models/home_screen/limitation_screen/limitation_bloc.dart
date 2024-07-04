import 'package:fitness_coach_app/models/home_screen/home_bloc.dart';
import 'package:fitness_coach_app/models/home_screen/limitation_screen/limitation_dm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LimitationBloc extends Bloc<LimitationBlocEvent, LimitationBlocState> {
  List<LimitationListDm> selectedLimitation = [];
  BuildContext currentContext;
  LimitationBloc(this.currentContext) : super(InitState()) {
    on<SelectLimitationEvent>((event, emit) {
      event.limitationListDm?.isSelected = event.isSelected;
      bool isAlready = selectedLimitation.contains(event.limitationListDm);
      if (event.limitationListDm != null) {
        if (isAlready) {
        } else {
          selectedLimitation.add(event.limitationListDm!);
        }
      }
      BlocProvider.of<HomeBloc>(currentContext)
          .add(SelectLimitationHomeEvent(selectedLimitation));
      emit(LimitationScessState(selectedLimitation[event.currentIndex ?? 0]));
    });
    on<SelectLimitationItemEvent>((event, emit) {
      event.limitationDm?.isSelected =
          !(event.limitationDm?.isSelected ?? false);
      List<LimitationDm>? listDm = selectedLimitation[event.currentIndex]
          .limitationList
          ?.where(
            (element) => element.title == event.limitationDm?.title,
          )
          .toList();
      listDm?.forEach(
        (element) {
          selectedLimitation[event.currentIndex]
              .limitationList?[element.index!] = element;
        },
      );
      BlocProvider.of<HomeBloc>(currentContext)
          .add(SelectLimitationHomeEvent(selectedLimitation));
      emit(LimitationScessState(selectedLimitation[event.currentIndex]));
    });
  }
}

abstract class LimitationBlocState {}

class InitState extends LimitationBlocState {}

class LimitationScessState extends LimitationBlocState {
  LimitationListDm? limitationListDm;
  LimitationScessState(this.limitationListDm);
}

abstract class LimitationBlocEvent {}

class SelectLimitationEvent extends LimitationBlocEvent {
  LimitationListDm? limitationListDm;
  int? currentIndex;
  bool isSelected;
  SelectLimitationEvent(
      {this.limitationListDm, this.currentIndex, this.isSelected = true});
}

class SelectLimitationItemEvent extends LimitationBlocEvent {
  LimitationDm? limitationDm;
  int currentIndex;
  SelectLimitationItemEvent({this.limitationDm, required this.currentIndex});
}
