import 'dart:async';
import 'Results.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../widgets/icon_content.dart';
import '../widgets/reusable_card.dart';
import '../utils/constants.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:bmi_calculator/widgets/progress.dart';
import 'package:bmi_calculator/enum.dart';
import 'package:bmi_calculator/widgets/custom_button.dart';

const double TAB_HEIGHT = 80.0;

enum Mode {
  chill,
  serious,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage>{
  Mode selectedMode = null;
  int height = 180;
  int weight = 74;
  int age = 19;

  int remainingTime = kSTUDY_TIME;
  String startBtnText = btnTextStart;
  AnimedoroStatus status = AnimedoroStatus.paused;
  Timer _timer;
  int setNum = 0;
  int pomodoroNum = 0;
  Icon_fill _timerBtnIcon = Icon_fill(icon: Icons.play_arrow, text: btnTextStart);
  Color testColor = kINACTIVE_CARD_COLOR;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        secondsToFormattedTime(remainingTime),
                        style: kNUMBER_STYLE,
                      ),

                    ],
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
                      setState(() {
                        selectedMode = Mode.chill;
                        print('chill');
                      });
                    },
                    colour: selectedMode == Mode.chill
                        ? kACTIVE_CARD_COLOR
                        : kINACTIVE_CARD_COLOR,
                    cardChild:
                    Icon_fill(icon: Icons.airline_seat_flat_angled_rounded, text: 'CHILL'),
                  ),
                ),
                Expanded(
                  //SERIOUS
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedMode = Mode.serious;
                      });
                    },
                    colour: selectedMode == Mode.serious
                        ? kACTIVE_CARD_COLOR
                        : kINACTIVE_CARD_COLOR,
                    cardChild: Icon_fill(
                        icon: Icons.auto_stories, text: 'SERIOUS'),
                  ),
                ),
              ],
            ),
          ),

          ///TIMER START BUTTON AND SOMETHING ELSE IN A ROW

          Expanded(
            child: Row(
              children: [
                Expanded(
                  //SERIOUS
                  child: ReusableCard(
                    cardChild: _timerBtnIcon,
                    colour: testColor,
                      // onPress: () {
                      //   setState(() {
                      //     testColor = kACTIVE_CARD_COLOR;
                      //   });
                      // }
                    ///WIERD problem, if I put this in a function it starts running automatically but putting the function's body directly in onPress solves the problem
                    onPress:() {
                      switch(status) {
                        case AnimedoroStatus.paused:
                          _animedoroCountdown();
                          break;
                        case AnimedoroStatus.running:
                        // TODO: Handle this case.
                          break;
                        case AnimedoroStatus.anime:
                        // TODO: Handle this case.
                          break;
                        case AnimedoroStatus.finished:
                        // TODO: Handle this case.
                          break;
                      }
                    },
                  ),
                ),

                Expanded(
                  child: ReusableCard(
                    colour: kINACTIVE_CARD_COLOR,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kLABEL_TEXT_STYLE,
                        ),
                        Text(
                          age.toString(),
                          style: kNUMBER_STYLE,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                                icon_child: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                }
                            ),
                            SizedBox(width: 10),
                            RoundIconButton(
                                icon_child: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                }
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                style: kRESULT_STYLE,
              ),
              Progress(
                total: pomodoroNum,
                done: pomodoroNum - (setNum*kPOMODORO_PER_sET),
              ),
              
            ],
          ),

          ///RESULT CALCULATOR BUTTON

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage()));
            },
            child: Container(
              child: Center(
                child: Text('CALCULATE',
                  style: kRESULT_STYLE,
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


  String secondsToFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String remainingSecondsFormatted;

    if(remainingSeconds < 10)
      remainingSecondsFormatted = '0$remainingSeconds';
    else
      remainingSecondsFormatted = remainingSeconds.toString();

    return '$minutes:$remainingSecondsFormatted';
  }

  // _mainBtnPressed() {
  //   switch(status) {
  //     case AnimedoroStatus.paused:
  //       _animedoroCountdown();
  //       break;
  //     case AnimedoroStatus.running:
  //       // TODO: Handle this case.
  //       break;
  //     case AnimedoroStatus.anime:
  //       // TODO: Handle this case.
  //       break;
  //     case AnimedoroStatus.finished:
  //       // TODO: Handle this case.
  //       break;
  //   }
  // }

  _animedoroCountdown() {
    print('running');
     status = AnimedoroStatus.running;
     _cancelTimer();
     
     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if(remainingTime > 0) {
          setState(() {
            remainingTime--;
            _timerBtnIcon = Icon_fill(icon: Icons.pause, text: btnTextPause);
          });
        }
        else {
          //TODO: PLAY SOUND ANIME RELATED
          pomodoroNum++;
          _cancelTimer();
          if(pomodoroNum == kPOMODORO_PER_sET) {
            print('4 sets done');
          }
          else {
            status = AnimedoroStatus.anime;
            setState(() {
              remainingTime = kANIME_TIME;
              _timerBtnIcon = Icon_fill(icon: Icons.tv_rounded, text: btnTextAnime);
            });
          }
        }
     });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

}

class RoundIconButton extends StatelessWidget {

  // ignore: non_constant_identifier_names
  RoundIconButton({@required this.icon_child, @required this.onPressed});
  // ignore: non_constant_identifier_names
  final IconData icon_child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      child: Icon(icon_child),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}

