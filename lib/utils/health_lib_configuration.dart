import 'dart:io';

import 'package:fitness_coach_app/utils/constants.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthLibConfiguration {
  init() async {
    try {
      await Health().configure(useHealthConnectIfAvailable: true);

      if (Platform.isAndroid) {
        await Health().installHealthConnect();
      }

      await Permission.activityRecognition.request();
      await Permission.location.request();

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
      bool? hasPermissions = await Health().hasPermissions(types, permissions: [
        HealthDataAccess.READ,
        HealthDataAccess.READ_WRITE,
        HealthDataAccess.WRITE
      ]);
      bool authorized = await Health().requestAuthorization(types,
          permissions: [
            HealthDataAccess.READ,
            HealthDataAccess.READ_WRITE,
            HealthDataAccess.WRITE
          ]);

      if (Platform.isAndroid) {
        final status = await Health().getHealthConnectSdkStatus();
        Constants.sucessLog(status);
      }
    } catch (e) {
      Constants.errorLog(e);
    }
  }
}
