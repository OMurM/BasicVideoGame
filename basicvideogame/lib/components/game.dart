// ignore_for_file: unused_import

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'background.dart';
import 'player.dart';
import 'enemy.dart';
import 'package:flame/input.dart';
import 'dart:math';
import 'dart:ui';
import 'hud.dart';
import 'game_over.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  double enemySpawnTimer = 0.0;
  double individualEnemySpawnTimer = 0.0;
  final double enemySpawnInterval = 5.0;
  final double individualEnemySpawnInterval = 0.2;
  int enemyCount = 1;
  int enemiesToSpawn = 0;
  final Random random = Random();
  int score = 0;
  double scoreAccumulator = 0.0;
  late Hud hud;
  String playerName;
  String difficultyLevel;

  MyGame(this.playerName, this.difficultyLevel);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background());
    add(Player());
    hud = Hud(playerName, difficultyLevel);
    add(hud);

    // Background music initialize
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('retro-game-arcade.mp3', volume: 0.25);

    // Ensure the game is not paused
    resumeEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawnTimer += dt;
    individualEnemySpawnTimer += dt;
    scoreAccumulator += dt * 10;

    if (scoreAccumulator >= 1.0) {
      score += scoreAccumulator.toInt();
      scoreAccumulator -= scoreAccumulator.toInt();
      hud.updateScore(score);
    }

    if (enemySpawnTimer >= enemySpawnInterval) {
      enemySpawnTimer = 0.0;
      enemiesToSpawn = enemyCount;
      enemyCount++;
    }

    if (individualEnemySpawnTimer >= individualEnemySpawnInterval && enemiesToSpawn > 0) {
      individualEnemySpawnTimer = 0.0;
      Vector2 spawnPosition;
      bool hasOverlap;
      int attempts = 0;
      do {
        spawnPosition = Vector2(0, random.nextDouble() * (size.y - 50));
        hasOverlap = children.whereType<Enemy>().any(
          (enemy) => enemy.toRect().overlaps(Rect.fromLTWH(spawnPosition.x, spawnPosition.y, 50, 50))
        );
        attempts++;
      } while (hasOverlap && attempts < 10);
      if (!hasOverlap) {
        add(Enemy()..position = spawnPosition);
        enemiesToSpawn--;
      } else {
      }
    }
  }

  void incrementScore(int points) {
    score += points;
    hud.updateScore(score);
  }

  void showGameOverScreen() {
    FlameAudio.bgm.stop();
    FlameAudio.play('game-over-arcade.mp3');
    overlays.add('gameOver');
    pauseEngine();
  }

  void reset() {
    removeAll(children.where((child) => child is! Background));
    enemySpawnTimer = 0.0;
    individualEnemySpawnTimer = 0.0;
    enemyCount = 1;
    enemiesToSpawn = 0;
    score = 0;
    scoreAccumulator = 0.0;
    add(Player());
    hud = Hud(playerName, difficultyLevel);
    add(hud);
    FlameAudio.bgm.play('retro-game-arcade.mp3', volume: 0.25);
    resumeEngine();
  }

  void pauseGame() {
    overlays.add('pauseMenu');
    FlameAudio.bgm.stop();
    pauseEngine();
  }

  void resumeGame() {
    overlays.remove('pauseMenu');
    FlameAudio.bgm.resume();
    resumeEngine();
  }
}