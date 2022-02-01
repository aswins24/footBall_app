import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_app/model/competition_detail.dart';
import 'package:football_app/utils/text_style.dart';

class CompetitionDetailCard extends StatefulWidget {
  final CompetitionDetail competitionDetail;

  const CompetitionDetailCard(this.competitionDetail, {Key? key})
      : super(key: key);

  @override
  _CompetitionDetailCardState createState() => _CompetitionDetailCardState();
}

class _CompetitionDetailCardState extends State<CompetitionDetailCard> {
  late Size size;
  late Orientation orientation;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;

    return Container(
      margin: EdgeInsets.all(size.width * 0.02),
      padding: EdgeInsets.all(orientation == Orientation.portrait
          ? size.width * 0.05
          : size.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.competitionDetail.emblemUrl != null
              ? SvgPicture.network(
                  widget.competitionDetail.emblemUrl!,
                  width: orientation == Orientation.portrait
                      ? size.width * 0.2
                      : size.width * 0.12,
                )
              : SizedBox(
                  height: orientation == Orientation.portrait
                      ? size.height * 0.05
                      : size.height * 0.2,
                ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            widget.competitionDetail.name!,
            textAlign: TextAlign.center,
            style: AppTextStyle.headingText,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.3
                    : size.width * 0.2,
                child: Text(
                  'Starting date: ${widget.competitionDetail.currentSeason!.startDate!}',
                  style: AppTextStyle.contentText,
                ),
              ),
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.3
                    : size.width * 0.2,
                child: Text(
                    'Ending date: ${widget.competitionDetail.currentSeason!.endDate!}',
                    style: AppTextStyle.contentText),
              )
            ],
          )
        ],
      ),
    );
  }
}
