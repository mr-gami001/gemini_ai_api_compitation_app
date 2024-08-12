import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen/home_screen.dart';
import '../splash_screen/splash_screen.dart';
import 'app_bloc.dart';

class AppLandingScreen extends StatefulWidget {
  const AppLandingScreen({super.key});

  @override
  State<AppLandingScreen> createState() => _AppLandingScreenState();
}

class _AppLandingScreenState extends State<AppLandingScreen> {
  AppBloc? appBloc;
  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    appBloc?.add(AppStartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: appBloc,
        builder: (context, state) {
          if (state is HomePageState) {
            return HomeScreen();
          }
          return const SplashScreen();
        });
  }
}
