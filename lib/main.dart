import 'package:fitness_coach_app/utils/health_lib_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'models/app_landing/app_bloc.dart';
import 'models/app_landing/app_landing_screen.dart';
import 'models/app_landing/dependecy_inject.dart';
import 'utils/constants.dart';

const apiKey = 'AIzaSyC9IYcQ5ZQ_NlBp4zsk7ZEKf4kvVVDcQTs';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  injectionSetup();
  HealthLibConfiguration().init();
  try {
    Constants.model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    Constants.sucessLog(Constants.model.toString());
  } catch (e) {
    Constants.errorLog(e);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AppBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppLandingScreen(),
      ),
    );
  }
}
