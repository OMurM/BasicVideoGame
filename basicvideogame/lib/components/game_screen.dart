import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:basicvideogame/components/game.dart' as flame_game;

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameInstance = flame_game.MyGame();
    
    return Scaffold(
      body: GameWidget(game: gameInstance),
    );
  }
}