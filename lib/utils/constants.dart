import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_app/model/competition.dart';

const token = '424909fe76a4472d899dbaead57d2b24';
const List<Competition> competitions = [
  //Competition('FIFA World Cup', 'WC'),
  Competition('UEFA Champions League', 'CL'),
  Competition('Bundesliga', 'BL1'),
  Competition('Eredivisie', 'DED'),
  Competition('Campeonato Brasileiro Série A', 'BSA'),
  Competition('Primera Division', 'PD'),
  Competition('Ligue 1', 'FL1'),
  Competition('Championship', 'ELC'),
  Competition('Primeira Liga', 'PPL'),
  Competition('European Championship', 'EC'),
  Competition('Serie A', 'SA'),
  Competition('Premier League', 'PL'),
  Competition('Copa Libertadores', 'CLI'),

];

const kProgressIndicator = Center(child: CircularProgressIndicator(),);
