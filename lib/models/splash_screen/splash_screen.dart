import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_landing/app_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  );
  late final Animation<double> _animation =
      Tween<double>(begin: 0, end: 1).animate(_controller);

  @override
  void initState() {
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        BlocProvider.of<AppBloc>(context).add(HomePageEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 100,
              ),
              // SizedBox(height: 20),
              // Text(
              //   'Welcome to My App',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
