import 'package:bmi_calculator/Screens/input_page.dart';
import 'package:bmi_calculator/utils/constants.dart';

class Calculate {
  int studyNum = 0;
  int animeCount = 0;
  int longBreakCount = 0;
  Mode mode = null;


  Calculate({this.studyNum, this.animeCount, this.longBreakCount, this.mode});

  String calculateStudy() {
    int studyTime = 0;
    if(mode == Mode.chill)
      studyTime = studyNum * kSTUDY_TIME_CHILL;
    else
      studyTime = studyNum * kSTUDY_TIME_SERIOUS;

    return studyTime.toString();
  }

  String calculateBreak() {
    int breakTime = animeCount*kANIME_TIME + longBreakCount*kLONG_BREAK_TIME;
    return breakTime.toString();
  }
}