import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc() : super(InitState()) {

    on<HomePageEvent>((event,state)=> emit(HomePageState()));

    on<AppStartEvent>((event, emit) async {
      emit(InitState());
      await Future.delayed(
        const Duration(seconds: 5),
      );
      add(HomePageEvent());
    });
  }
}

abstract class AppBlocState {}

class InitState extends AppBlocState {}

class HomePageState extends AppBlocState {}

abstract class AppBlocEvent {}

class AppStartEvent extends AppBlocEvent {}
class HomePageEvent extends AppBlocEvent {}
