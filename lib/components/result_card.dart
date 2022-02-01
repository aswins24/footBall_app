import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_app/model/team.dart';
import 'package:football_app/utils/text_style.dart';

class ResultCard extends StatelessWidget {
  final int score;
  final Team? team;
  late Size _size;
  late Orientation _orientation;

  ResultCard(this.score, this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _orientation = MediaQuery.of(context).orientation;
    return Container(
      margin: EdgeInsets.all(_size.width * 0.02),
      padding: EdgeInsets.all(_orientation == Orientation.portrait
          ? _size.width * 0.05
          : _size.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          team!.crestUrl != null
              ? SvgPicture.network(
                  team!.crestUrl!,
                  width: _orientation == Orientation.portrait
                      ? _size.width * 0.3
                      : _size.width * 0.2,
                )
              : SizedBox(
                  height: _orientation == Orientation.portrait
                      ? _size.height * 0.05
                      : _size.height * 0.2,
                ),
          SizedBox(
            height: _size.height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Team: ',
                  style:
                      AppTextStyle.headingText!.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                        text: team!.name!,
                        style: AppTextStyle.contentText!
                            .copyWith(color: Colors.red)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Wins: ',
                  style:
                      AppTextStyle.headingText!.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                        text: '$score',
                        style: AppTextStyle.contentText!
                            .copyWith(color: Colors.green)),
                  ],
                ),
              ),
            ],
            //  Text('Team: ${team!.name!}'), Text('Wins: $score')],
          ),
        ],
      ),
    );
  }
}
