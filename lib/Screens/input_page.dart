import 'dart:async';
import 'package:bmi_calculator/calculate.dart';

import 'Results.dart';
import 'package:flutter/material.dart';
import '../widgets/icon_content.dart';
import '../widgets/reusable_card.dart';
import '../utils/constants.dart';
import 'package:bmi_calculator/widgets/progress.dart';
import 'package:bmi_calculator/enum.dart';
import 'package:audioplayers/audio_cache.dart';

const double TAB_HEIGHT = 80.0;

enum Mode {
  chill,
  serious,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  //TODO: implemet mode selection, 60min and 37min

  Mode selectedMode = Mode.chill;
  bool _enabled = true;
  final player = AudioCache();
  int remainingTime = kSTUDY_TIME_CHILL;
  String startBtnText = btnTextStart;
  static AnimedoroStatus status = AnimedoroStatus.paused;
  Timer _timer;
  int setNum = 0;
  int pomodoroNum = 0; //times studies
  int animeNum = 0; //times watched anime
  int longBreakNum = 0; //times taken long breaks
  Icon_fill _timerBtnIcon =
      Icon_fill(icon: Icons.play_arrow_rounded, text: btnTextStart);

  Icon_fill _resetBtnIcon =
      Icon_fill(icon: Icons.refresh_rounded, text: btnTextReset);

  Color playBtnColor = kINACTIVE_CARD_COLOR;
  Color resetBtnColor = kINACTIVE_CARD_COLOR;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    player.load('bell.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ANIMEDORO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),

          ///TIMER CARD

          Expanded(
            child: ReusableCard(
              colour: kACTIVE_CARD_COLOR,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'STUDY TIMER',
                    style: kLABEL_TEXT_STYLE,
                  ),
                  SizedBox(height: 5),
                  Text(
                    secondsToFormattedTime(remainingTime),
                    style: kNUMBER_STYLE,
                  ),
                  SizedBox(height: 5),
                  Text(
                    message[status],
                    style: kLABEL_TEXT_STYLE,
                  )
                ],
              ),
            ),
          ),

          ///CHILL AND SERIOUS MODE CARDS IN A ROW

          Expanded(
            child: Row(
              children: [
                Expanded(
                  //CHILL
                  child: ReusableCard(
                    onPress: () {
                      if (_enabled) {
                        setState(() {
                          selectedMode = Mode.chill;
                          remainingTime = kSTUDY_TIME_CHILL;
                          print('chill');
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    colour: selectedMode == Mode.chill
                        ? kACTIVE_CARD_COLOR
                        : kINACTIVE_CARD_COLOR,
                    cardChild: Icon_fill(
                        icon: Icons.airline_seat_flat_angled_rounded,
                        text: 'CHILL'),
                  ),
                ),
                Expanded(
                  //SERIOUS
                  child: ReusableCard(
                    onPress: () {
                      if (_enabled) {
                        setState(() {
                          selectedMode = Mode.serious;
                          remainingTime = kSTUDY_TIME_SERIOUS;
                          print('serious');
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    colour: selectedMode == Mode.serious
                        ? kACTIVE_CARD_COLOR
                        : kINACTIVE_CARD_COLOR,
                    cardChild:
                        Icon_fill(icon: Icons.auto_stories, text: 'SERIOUS'),
                  ),
                ),
              ],
            ),
          ),

          ///TIMER START BUTTON AND RESET BTN IN A ROW

          Expanded(
            child: Row(
              children: [
                Expanded(
                  //SERIOUS
                  child: ReusableCard(
                    cardChild: _timerBtnIcon,
                    colour: playBtnColor,

                    ///WIERD problem, if I put this in a function it starts running automatically but putting the function's body directly in onPress solves the problem
                    onPress: () {
                      print('Main btn pressed');
                      switch (status) {
                        case AnimedoroStatus.paused:
                          _animedoroCountdown();
                          break;
                        case AnimedoroStatus.running:
                          _animedoroPause(
                              displayIcon: Icons.play_arrow_rounded);
                          break;
                        case AnimedoroStatus.animeRunning:
                          _animedoroPauseAnimeBreak();
                          break;
                        case AnimedoroStatus.animePaused:
                          _animedoroAnimeCountdown();
                          break;
                        case AnimedoroStatus.finished:
                          setNum++;
                          _animedoroCountdown();
                          break;
                        case AnimedoroStatus.longBreak:
                          _animedoroPauseLongBreak();
                          break;
                        case AnimedoroStatus.pauseLongBreak:
                          _animedoroLongBreakCountdown();
                          break;
                      }
                    },
                  ),
                ),
                Expanded(
                  //SERIOUS
                  child: ReusableCard(
                      cardChild: _resetBtnIcon,
                      colour: resetBtnColor,
                      onPress: () {
                        _animedoroReset();
                      }),
                ),
              ],
            ),
          ),

          ///ANIMEDORO PROGRESS INDICATORS IN A ROW

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'SET : $setNum',
                style: kSET_STYLE,
              ),
              Progress(
                total: kPOMODORO_PER_sET,
                done: pomodoroNum - (setNum * kPOMODORO_PER_sET),
              ),
            ],
          ),

          ///CALCULATOR BUTTON

          GestureDetector(
            onTap: () {
              //TODO: fix calculate of mode change.
              ///Suppose user doesnt press calculate till all all pomodoro's are done. Then changes the mode and midway presses calculate.
              /// It would give the wrong answer cause the previous study time was in a different mode. Maybe call calculate after each set
              /// finished or long break finished
              Calculate calc = Calculate(
                  studyNum: pomodoroNum,
                  animeCount: animeNum,
                  longBreakCount: longBreakNum,
                  mode: selectedMode);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            timeStudied: calc.calculateStudy(),
                            timeAnimeWatched: calc.calculateBreak(),
                          )));
            },
            child: Container(
              child: Center(
                child: Text(
                  'CALCULATE',
                  style: kSET_STYLE,
                  textAlign: TextAlign.center,
                ),
              ),
              color: kBOTTOM_TAB_COLOR,
              margin: EdgeInsets.only(top: 5.0),
              width: double.infinity,
              height: TAB_HEIGHT,
            ),
          ),
        ],
      ),
    );
  }

  _animedoroReset() {
    pomodoroNum = 0;
    setNum = 0;
    _enabled = true;
    _cancelTimer();
    _animedoroStop();
  }

  _animedoroStop() {
    status = AnimedoroStatus.paused;
    setState(() {
      resetBtnColor = kACTIVE_CARD_COLOR;
      _timerBtnIcon =
          Icon_fill(icon: Icons.play_arrow_rounded, text: btnTextStart);
      remainingTime = kSTUDY_TIME_CHILL;
    });
  }

  ///Universal Pause function used for study time pause, anime break time pause, long break time pause.
  _animedoroPause(
      {@required IconData displayIcon, AnimedoroStatus currentStatus}) {
    //if currentStatus not passed then status by default = study time pause
    currentStatus == null
        ? status = AnimedoroStatus.paused
        : status = currentStatus;
    _cancelTimer();
    setState(() {
      if (resetBtnColor != kINACTIVE_CARD_COLOR)
        resetBtnColor = kINACTIVE_CARD_COLOR;
      playBtnColor = kACTIVE_CARD_COLOR;
      _timerBtnIcon = Icon_fill(icon: displayIcon, text: btnTextResume);
    });
  }

  _animedoroPauseAnimeBreak() {
    status = AnimedoroStatus.animePaused;
    _animedoroPause(displayIcon: Icons.tv_rounded, currentStatus: status);
  }

  _animedoroPauseLongBreak() {
    status = AnimedoroStatus.pauseLongBreak;
    _animedoroPause(
        displayIcon: Icons.play_arrow_rounded, currentStatus: status);
  }

  _animedoroCountdown() {
    setState(() {
      _enabled = false;
      if (resetBtnColor != kINACTIVE_CARD_COLOR)
        resetBtnColor = kINACTIVE_CARD_COLOR;
      playBtnColor = kACTIVE_CARD_COLOR;
      _timerBtnIcon = Icon_fill(icon: Icons.pause, text: btnTextPause);
    });

    status = AnimedoroStatus.running;

    _cancelTimer();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _playSound();
        pomodoroNum++;
        _cancelTimer();
        if (pomodoroNum % kPOMODORO_PER_sET == 0) {
          //pomodoroNum should be multiples of pomodoroperSet, 8 pomodoroNum = 2 sets done, 12 pom = 3 sets....
          status = AnimedoroStatus.pauseLongBreak;
          setState(() {
            remainingTime = kLONG_BREAK_TIME;
            _timerBtnIcon = Icon_fill(
                icon: Icons.play_arrow_rounded, text: btnTextLongBreak);
          });
        } else {
          status = AnimedoroStatus.animePaused;
          setState(() {
            remainingTime = kANIME_TIME;
            _timerBtnIcon =
                Icon_fill(icon: Icons.tv_rounded, text: btnTextAnime);
          });
        }
      }
    });
  }

  _animedoroAnimeCountdown() {
    status = AnimedoroStatus.animeRunning;
    _cancelTimer();
    setState(() {
      _timerBtnIcon = Icon_fill(icon: Icons.tv_off_rounded, text: btnTextAnime);
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _playSound();
        animeNum++;
        _cancelTimer();
        remainingTime = kSTUDY_TIME_CHILL;
        status = AnimedoroStatus.paused;
        setState(() {
          _timerBtnIcon =
              Icon_fill(icon: Icons.play_arrow_rounded, text: btnTextStart);
        });
      }
    });
  }

  _animedoroLongBreakCountdown() {
    status = AnimedoroStatus.longBreak;
    _cancelTimer();
    setState(() {
      _timerBtnIcon = Icon_fill(icon: Icons.pause, text: btnTextLongBreak);
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _playSound();
        longBreakNum++;
        _cancelTimer();
        remainingTime = kSTUDY_TIME_CHILL;
        status = AnimedoroStatus.finished;
        _enabled = true;
        setState(() {
          // _enabled = true;
          _timerBtnIcon =
              Icon_fill(icon: Icons.play_arrow_rounded, text: btnTextStart);
        });
      }
    });
  }

  _playSound() {
    // print('play sound');
    player.play('bell.mp3');
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  String secondsToFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String remainingSecondsFormatted;

    if (remainingSeconds < 10)
      remainingSecondsFormatted = '0$remainingSeconds';
    else
      remainingSecondsFormatted = remainingSeconds.toString();

    return '$minutes:$remainingSecondsFormatted';
  }
}
