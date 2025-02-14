import 'package:flame/game.dart';
import 'background.dart';
import 'player.dart';
import 'enemy.dart';
import 'package:flame/input.dart';
import 'dart:math';
import 'dart:ui';

class MyGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  double enemySpawnTimer = 0.0;
  final double enemySpawnInterval = 5.0;
  int enemyCount = 1;
  final Random random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background());
    add(Player());
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawnTimer += dt;
    if (enemySpawnTimer >= enemySpawnInterval) {
      enemySpawnTimer = 0.0;
      for (int i = 0; i < enemyCount; i++) {
        Vector2 spawnPosition;
        bool hasOverlap;
        int attempts = 0;
        do {
          spawnPosition = Vector2(0, random.nextDouble() * (size.y - 50));
          hasOverlap = children.whereType<Enemy>().any(
            (enemy) => enemy.toRect().overlaps(Rect.fromLTWH(spawnPosition.x, spawnPosition.y, enemy.width, enemy.height))
          );
          attempts++;
        } while (hasOverlap && attempts < 10);
        if (!hasOverlap) {
          add(Enemy()..position = spawnPosition);
        }
      }
      enemyCount++;
    }
  }

  void showGameOverScreen() {
    overlays.add('gameOver');
    pauseEngine();
  }

  void reset() {
    removeAll(children.where((child) => child is! Background));
    enemySpawnTimer = 0.0;
    enemyCount = 1;
    add(Player());
    resumeEngine();
  }
}