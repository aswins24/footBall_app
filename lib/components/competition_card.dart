import 'package:flutter/material.dart';
import 'package:football_app/model/competition.dart';
import 'package:football_app/utils/text_style.dart';

class CompetitionCard extends StatelessWidget {
  final Competition competition;

  const CompetitionCard(this.competition, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          competition.title,
          textAlign: TextAlign.center,
          style: AppTextStyle.headingText,
        ),
      ),
    );
  }
}
