import 'package:flame/game.dart';
import 'background.dart';
import 'player.dart';
import 'enemy.dart';
import 'package:flame/input.dart';
import 'dart:math';
import 'dart:ui';
import 'hud.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
double enemySpawnTimer = 0.0;
  double individualEnemySpawnTimer = 0.0;
  final double enemySpawnInterval = 5.0;
  final double individualEnemySpawnInterval = 0.2;
  int enemyCount = 1;
  int enemiesToSpawn = 0;
  final Random random = Random();
  int score = 0;
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
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawnTimer += dt;
    individualEnemySpawnTimer += dt;
    score += (dt * 100).toInt();
    hud.updateScore(score);

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
          (enemy) => enemy.toRect().overlaps(Rect.fromLTWH(spawnPosition.x, spawnPosition.y, 50, 50)) // Adjusted to match enemy size
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

  void showGameOverScreen() {
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
    add(Player());
    resumeEngine();
  }
}