import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game.dart';
import 'game_over.dart';

class GameScreen extends StatelessWidget {
  final String playerName;
  final String difficultyLevel;

  const GameScreen({super.key, required this.playerName, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MyGame(playerName, difficultyLevel),
        overlayBuilderMap: {
          'gameOver': (context, game) => GameOverScreen(game: game as MyGame),
        },
      ),
    );
  }
}