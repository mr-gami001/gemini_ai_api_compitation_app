import 'package:fitness_coach_app/models/home_screen/home_repo.dart';
import 'package:get_it/get_it.dart';

import '../../utils/text_style.dart';

GetIt getIt = GetIt.instance;

injectionSetup() {
  getIt.registerSingleton<AppTextStyle>(AppTextStyle());
  getIt.registerSingleton<HomeRepo>(HomeRepo());
}
