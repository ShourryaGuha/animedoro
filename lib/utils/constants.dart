import 'package:flutter/material.dart';
import 'package:bmi_calculator/enum.dart';

const kACTIVE_CARD_COLOR = Color(0xFF1D1E33);
const kINACTIVE_CARD_COLOR = Color(0xFF111328);
const kBOTTOM_TAB_COLOR = Color(0XFFEB1555);
const kLABEL_TEXT_STYLE = TextStyle(
  color: Color(0xFF8D8E98),
  fontSize: 19,
);
const kNUMBER_STYLE =  TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);
const kRESULT_STYLE = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

// const int kSTUDY_TIME = 37*60;
// const int kANIME_TIME = 23*60;
// const int kLONG_BREAK_TIME = 40*60;
// const int kPOMODORO_PER_sET = 4;

const int kSTUDY_TIME = 6;
const int kANIME_TIME = 4;
const int kLONG_BREAK_TIME = 5;
const int kPOMODORO_PER_sET = 4;

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
