import 'package:flutter/material.dart';
import 'package:football_teams/pages/home_page.dart';
import 'package:football_teams/services/player_repository.dart';
import 'package:football_teams/themes/themes.dart';

void main() {
  PlayerRepository _repository = PlayerRepository();
  runApp(MyApp(
    playerRepository: _repository,
  ));
}

class MyApp extends StatelessWidget {
  final PlayerRepository playerRepository;

  MyApp({this.playerRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Implementation',
      theme: ThemeData(
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            textTheme: TextTheme(title: appBarTextStyle),
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      home: HomePage(playerRepository: playerRepository),
    );
  }
}
