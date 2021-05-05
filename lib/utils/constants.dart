import 'package:flutter/material.dart';
import 'package:bmi_calculator/enum.dart';

const kACTIVE_CARD_COLOR = Color(0xFF1D1E33);
const kINACTIVE_CARD_COLOR = Color(0xFF111328);
const kBOTTOM_TAB_COLOR = Color(0XFFEB1555);
const kRESULT_LABEL_STYLE = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.w900,
);
const kLABEL_TEXT_STYLE = TextStyle(
  color: Color(0xFF8D8E98),
  fontSize: 19,
);
const kNUMBER_STYLE =  TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);
const kSET_STYLE = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);
const kRESULT_STYLE = TextStyle(
  color: Color(0xFF8D8E98),
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

const snackBar = SnackBar(
  backgroundColor: kINACTIVE_CARD_COLOR,
  content: Text(
    'Modes can\'t be changed until 1 set is over',
    style: TextStyle(
      color: Colors.white70,
      fontSize: 15,
    ),
  ),
  duration: Duration(seconds: 1),
);

const int kSTUDY_TIME_SERIOUS = 60*60;
const int kSTUDY_TIME_CHILL = 37*60;
const int kANIME_TIME = 23*60;
const int kLONG_BREAK_TIME = 40*60;
const int kPOMODORO_PER_sET = 4;

///FOR testing purposes
// const int kSTUDY_TIME_SERIOUS = 10;
// const int kSTUDY_TIME_CHILL = 6;
// const int kANIME_TIME = 4;
// const int kLONG_BREAK_TIME = 5;
// const int kPOMODORO_PER_sET = 4;

const Map<AnimedoroStatus, String> message = {
  AnimedoroStatus.animeRunning : 'Anime Time!',
  AnimedoroStatus.animePaused : 'Start anime!',
  AnimedoroStatus.longBreak : 'Just relax',
  AnimedoroStatus.pauseLongBreak : 'Just relax',
  AnimedoroStatus.finished : 'Congrats!',
  AnimedoroStatus.paused : 'Ready to Start?',
  AnimedoroStatus.running : 'You got this!',
};

const btnTextStart = 'START';
const btnTextResume = 'RESUME';
const btnTextPause = 'PAUSE';
const btnTextAnime = 'BREAK';
const btnTextLongBreak = 'RELAX';
const btnTextReset = 'RESET';
