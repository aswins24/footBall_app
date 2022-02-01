import 'package:flutter/material.dart';
import 'package:football_app/components/competition_card.dart';
import 'package:football_app/components/competition_detail_card.dart';
import 'package:football_app/model/match_result.dart';
import 'package:football_app/providers/competition_detail_provider.dart';
import 'package:football_app/providers/competition_result.dart';
import 'package:football_app/providers/team_detail_provider.dart';
import 'package:football_app/service/api_service.dart';
import 'package:football_app/utils/constants.dart';
import 'package:football_app/utils/text_style.dart';
import 'package:provider/provider.dart';

import 'components/result_card.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => CompetitionDetailProvider(),
    ),
    ChangeNotifierProxyProvider<CompetitionDetailProvider, TeamDetails>(
      create: (context) => TeamDetails(null),
      update: (context, competitionDetail, teamDetail) =>
          teamDetail!..update(competitionDetail),
    ),
    ChangeNotifierProxyProvider<TeamDetails, CompetitionResult>(
        create: (context) => CompetitionResult(null),
        update: (context, teamDetail, competitionResult) =>
            competitionResult!..update(teamDetail))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Foot Ball App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CompetitionDetailProvider? _competitionDetailProvider;
  TeamDetails? _teamDetails;
  CompetitionResult? _competitionResult;
  late Size size;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _competitionDetailProvider = Provider.of<CompetitionDetailProvider>(
      context,
    );
    _teamDetails = Provider.of<TeamDetails>(
      context,
    );
    _competitionResult = Provider.of<CompetitionResult>(context);


    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: orientation == Orientation.portrait
            ? getPortraitView()
            : getLandscapeView(),

      ),
    );
  }
//UI once a particular competition is selected
  getCompetitionData() {
    return Consumer<CompetitionDetailProvider>(
      builder: (context, model, widget) {
        if (model.isLoading == null) {
          return Container();
        }
        if (model.isLoading!) {
          return kProgressIndicator;
        }
        if (!model.isLoading! && model.failureMessage.isNotEmpty) {
          return Center(
            child: Text(model.failureMessage, style: AppTextStyle.contentText,),
          );
        }
        if (!model.isLoading! && model.competitionDetail == null) {
          return  Center(
            child: Text('Something went wrong', style: AppTextStyle.contentText,),
          );
        }
        return CompetitionDetailCard(model.competitionDetail!);
      },
    );
  }

  getResultData() {
    return Consumer<CompetitionResult>(
      builder: (context, model, widget) {
        if (model.isLoading) {
          return kProgressIndicator;
        }
        if (!model.isLoading && model.failureMessage.isNotEmpty) {
          return Center(
            child: Text(
              model.failureMessage,
              style: AppTextStyle.contentText,
            ),
          );
        }
        if (!model.isLoading && model.matchResults.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: AppTextStyle.contentText,
            ),
          );
        }
        if (model.maxScore > 0 && model.team != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most wins during ',
                      style: AppTextStyle.headingText,
                    ),
                    Text(
                      '${model.startDateAsString} - ${model.endDateAsString}',
                      style: AppTextStyle.headingText,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ResultCard(model.maxScore, model.team),
            ],
          );
        } else {
          return  Center(
            child: Text('No results found', style: AppTextStyle.contentText,),
          );
        }
      },
    );
  }
//Main View for portrait mode
  getPortraitView() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                _competitionDetailProvider!.setCurrentCompetition(index);
                _competitionDetailProvider!
                    .fetchCompetitionDetails()
                    .whenComplete(() => _teamDetails!
                        .fetchTeamsForCompetition()
                        .whenComplete(
                            () => _competitionResult!.fetchMatchResults()));
              },
              child: SizedBox(
                  width: size.height * 0.2,
                  child: CompetitionCard(competitions[index])),
            ),
            itemCount: competitions.length,
          ),
        ),
        getCompetitionData(),
        if (_teamDetails != null &&
            _teamDetails!.teams.isNotEmpty &&
            !_teamDetails!.isLoading)
          getResultData(),
      ],
    );
  }
//Main view for landscape mode
  getLandscapeView() {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.2,
          height: size.height,
          child: ListView.builder(
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  _competitionDetailProvider!.setCurrentCompetition(index);
                  _competitionDetailProvider!
                      .fetchCompetitionDetails()
                      .whenComplete(() => _teamDetails!
                          .fetchTeamsForCompetition()
                          .whenComplete(
                              () => _competitionResult!.fetchMatchResults()));
                },
                child: SizedBox(
                    height: size.width * 0.1,
                    child: CompetitionCard(competitions[index]))),
            itemCount: competitions.length,
          ),
        ),
        SizedBox(
          // height: size.height,
          width: size.width * 0.7,
          child: ListView(

            children: [
              getCompetitionData(),
              if (_teamDetails != null &&
                  _teamDetails!.teams.isNotEmpty &&
                  !_teamDetails!.isLoading)
                getResultData(),
            ],
          ),
        )
      ],
    );
  }
}
