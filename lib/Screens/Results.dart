import 'package:bmi_calculator/Screens/input_page.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:bmi_calculator/widgets/reusable_card.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {

  String timeStudied;
  String timeAnimeWatched;

  ResultsPage({this.timeStudied, this.timeAnimeWatched});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESULTS'),
      ),
      body: Column(
        //TODO: weird error where its not expanding completely till crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ReusableCard(
              colour: kACTIVE_CARD_COLOR,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Time Studied',
                    style: kRESULT_LABEL_STYLE,
                  ),
                  SizedBox(height: 5),
                  Text(timeStudied+'min',
                    style: kRESULT_STYLE,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Anime time',
                    style: kRESULT_LABEL_STYLE,
                  ),
                  SizedBox(height: 5),
                  Text(timeAnimeWatched+'min',
                    style: kRESULT_STYLE,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
