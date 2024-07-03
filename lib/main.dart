import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';
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
  Health().configure(useHealthConnectIfAvailable: true);
  await Health().installHealthConnect();
  await Permission.activityRecognition.request();
  await Permission.location.request();
  final types = [
    HealthDataType.WEIGHT,
    HealthDataType.STEPS,
    HealthDataType.HEIGHT,
    // HealthDataType.BLOOD_GLUCOSE,
    // HealthDataType.WORKOUT,
    // HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    // HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    // Uncomment this line on iOS - only available on iOS
    // HealthDataType.AUDIOGRAM
  ];
  bool? hasPermissions =  await Health().hasPermissions(types, permissions: [
    HealthDataAccess.READ,
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.WRITE
  ]);
 bool authorized = await Health()
      .requestAuthorization(types, permissions: [
   HealthDataAccess.READ,
   HealthDataAccess.READ_WRITE,
   HealthDataAccess.WRITE
 ]);



  final status = await Health().getHealthConnectSdkStatus();
  print(status);
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
