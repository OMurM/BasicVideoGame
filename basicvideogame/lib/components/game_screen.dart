import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game.dart';
import 'game_over.dart';
import 'pause_menu.dart';

class GameScreen extends StatelessWidget {
  final String playerName;
  final String difficultyLevel;

  const GameScreen({super.key, required this.playerName, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    final MyGame game = MyGame(playerName, difficultyLevel);

    return Scaffold(
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          'gameOver': (context, game) => GameOverScreen(game: game as MyGame),
          'pauseMenu': (context, game) => PauseMenu(game: game as MyGame),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          game.pauseGame();
        },
        child: const Icon(Icons.pause),
      ),
    );
  }
}