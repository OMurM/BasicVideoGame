import 'package:flutter/material.dart';
import 'game.dart';

class GameOverScreen extends StatelessWidget {
  final MyGame game;
  final int score;

  const GameOverScreen({super.key, required this.game, required this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Game Over', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          Text('Score: $score', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              game.overlays.remove('gameOver');
              game.resumeEngine();
              game.reset();
            },
            child: const Text('Restart'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}