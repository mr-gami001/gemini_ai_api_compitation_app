import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Constants {
  static late GenerativeModel model;

  static errorLog(e) {
    return print('\x1B[31m${e.toString()}\x1B[0m');
  }

  static sucessLog(successText) {
    return print('\x1B[32m${successText.toString()}\x1B[0m');
  }

  static ValueNotifier<String> currentLevel = ValueNotifier<String>("") ;


  ///images path
  static String improveOverallHealth = "assets/images/improveOverallHealth.jpeg";
  static String specificEvent = "assets/images/specificEvent.jpeg";
  static String improveForParticularSport = "assets/images/improveForParticularSport.jpeg";
  static String moreTonedPhysique = "assets/images/moreTonedPhysique.jpeg";
  static String heartGif = "assets/images/heartGif.gif";
}
