import 'dart:io';

import 'package:fitness_coach_app/utils/constants.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthLibConfiguration {
  init() async {
    try {
      await Permission.activityRecognition.request();
      await Permission.location.request();
      await Health().configure(useHealthConnectIfAvailable: true);

      //
      final types = [
        HealthDataType.WEIGHT,
        HealthDataType.STEPS,
        HealthDataType.HEIGHT,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.WORKOUT,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      ];
      // Uncomment this line on iOS - only available on iOS
      if (Platform.isIOS) {
        types.add(HealthDataType.AUDIOGRAM);
      }
      // bool? hasPermissions = await Health().hasPermissions(types, permissions: [
      //   HealthDataAccess.READ,
      //   HealthDataAccess.READ_WRITE,
      //   HealthDataAccess.WRITE
      // ]);
      // bool authorized = await Health().requestAuthorization(types,
      //     permissions: [
      //       HealthDataAccess.READ,
      //       HealthDataAccess.READ_WRITE,
      //       HealthDataAccess.WRITE
      //     ]);

      if (Platform.isAndroid) {
        final status = await Health().getHealthConnectSdkStatus();
        Constants.sucessLog(status);
      }
    } catch (e) {
      Constants.errorLog(e);
    }
  }

  initial() async {
    // configure the health plugin before use.
    Health().configure(useHealthConnectIfAvailable: true);

    /// Install Google Health Connect on this phone.

    await Health().installHealthConnect();

    // define the types to get
    var types = [
      // HealthDataType.ACTIVE_ENERGY_BURNED,
      // HealthDataType.BASAL_ENERGY_BURNED,
      HealthDataType.BLOOD_GLUCOSE,
      // HealthDataType.BLOOD_OXYGEN,
      // HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      // HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      // HealthDataType.BODY_FAT_PERCENTAGE,
      // HealthDataType.BODY_MASS_INDEX,
      // HealthDataType.BODY_TEMPERATURE,
      // HealthDataType.BODY_WATER_MASS,
      // HealthDataType.ELECTRODERMAL_ACTIVITY,
      // HealthDataType.HEIGHT,
      // HealthDataType.RESTING_HEART_RATE,
      // HealthDataType.RESPIRATORY_RATE,
      HealthDataType.STEPS,
      // HealthDataType.WAIST_CIRCUMFERENCE,
      // HealthDataType.WALKING_HEART_RATE,
      // HealthDataType.WEIGHT,
      // HealthDataType.DISTANCE_WALKING_RUNNING,
      // HealthDataType.FLIGHTS_CLIMBED,
      // HealthDataType.MOVE_MINUTES,
      // HealthDataType.DISTANCE_DELTA,
      // HealthDataType.MINDFULNESS,
      // HealthDataType.SLEEP_IN_BED,
      // HealthDataType.SLEEP_ASLEEP,
      // HealthDataType.SLEEP_AWAKE,
      // HealthDataType.SLEEP_DEEP,
      // HealthDataType.SLEEP_LIGHT,
      // HealthDataType.SLEEP_REM,
      // HealthDataType.SLEEP_OUT_OF_BED,
      // HealthDataType.SLEEP_SESSION,
      // HealthDataType.WATER,
      // HealthDataType.EXERCISE_TIME,
      // HealthDataType.WORKOUT,
      // HealthDataType.HIGH_HEART_RATE_EVENT,
      // HealthDataType.LOW_HEART_RATE_EVENT,
      // HealthDataType.IRREGULAR_HEART_RATE_EVENT,
      // HealthDataType.HEART_RATE_VARIABILITY_SDNN,
      // HealthDataType.HEADACHE_NOT_PRESENT,
      // HealthDataType.HEADACHE_MILD,
      // HealthDataType.HEADACHE_MODERATE,
      // HealthDataType.HEADACHE_SEVERE,
      // HealthDataType.HEADACHE_UNSPECIFIED,
      // HealthDataType.AUDIOGRAM,
      // HealthDataType.ELECTROCARDIOGRAM,
      // HealthDataType.NUTRITION,
    ];

    // request permissions to write steps and blood glucose
    var permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE
    ];
    await Health().requestAuthorization(types, permissions: permissions);

    var now = DateTime.now();

    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: types, startTime: now.subtract(Duration(days: 1)), endTime: now);

    // write steps and blood glucose
    bool success = await Health().writeHealthData(
        value: 10,
        type: HealthDataType.STEPS,
        startTime: now.subtract(Duration(days: 1)),
        endTime: now);
    success = await Health().writeHealthData(
        value: 3.1,
        type: HealthDataType.BLOOD_GLUCOSE,
        startTime: now.subtract(Duration(days: 1)),
        endTime: now);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await Health().getTotalStepsInInterval(midnight, now);
  }
}
