// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'components/game.dart';
import 'components/main_menu.dart';
import 'components/game_over.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Video Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMenu(),
    );
  }
}