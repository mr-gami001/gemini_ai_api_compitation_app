import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../utils/text_style.dart';

GetIt getIt = GetIt.instance;

injectionSetup(){
  getIt.registerSingleton<AppTextStyle>(AppTextStyle());
}
