
import 'package:flutter_bloc/flutter_bloc.dart';

class LimitationBloc extends Bloc<LimitationBlocEvent, LimitationBlocState> {
  LimitationBloc() : super(InitState()) {
    on<PhysicalLimitEvent>((event, emit) => emit(PhysicalLimitState()));
    on<TimeLimitEvent>((event, emit) => emit(TimeLimitState()));
    on<SkillLimitEvent>((event, emit) => emit(SkillLimitState()));
    on<MotivationalLimitEvent>((event, emit) => emit(MotivationalLimitState()));
  }
}

abstract class LimitationBlocState {}

class InitState extends LimitationBlocState {}

class PhysicalLimitState extends LimitationBlocState {}

class TimeLimitState extends LimitationBlocState {}

class SkillLimitState extends LimitationBlocState {}

class MotivationalLimitState extends LimitationBlocState {}

abstract class LimitationBlocEvent {}

class PhysicalLimitEvent extends LimitationBlocEvent {}

class TimeLimitEvent extends LimitationBlocEvent {}

class SkillLimitEvent extends LimitationBlocEvent {}

class MotivationalLimitEvent extends LimitationBlocEvent {}
