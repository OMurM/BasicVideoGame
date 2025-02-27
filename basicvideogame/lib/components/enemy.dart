// ignore_for_file: unused_import

import 'dart:math';
import 'package:basicvideogame/components/game.dart';
import 'package:basicvideogame/components/bullet.dart';
import 'package:basicvideogame/components/enemy_bullet.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'player.dart';

class Enemy extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  double speed = 100;
  final Random random = Random();
  late Timer shootTimer;

  Enemy() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('enemy.png');
    size = Vector2(50, 50);
    angle = 3.14159 / 2;
  
    position = Vector2(
      -size.x / 2,
      random.nextDouble() * (gameRef.size.y - size.y) + size.y / 2
      );

      final hitbox = PolygonHitbox([
      Vector2(25, 0),
      Vector2(50, 50),
      Vector2(0, 50),
    ]);

    hitbox.debugMode = true; // false later when showing
    add(hitbox);

    if (gameRef.difficultyLevel == "Hard") {
      shootTimer = Timer(3, repeat: true, onTick: shoot);
      shootTimer.start();
    }
  }

  void shoot() {
    final bullet = EnemyBullet(position.clone());
    bullet.angle = 0;
    gameRef.add(bullet);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += speed * dt;

    if (position.x > gameRef.size.x) {
      removeFromParent();
    }
    
    if (gameRef.difficultyLevel == "Hard") {
      shootTimer.update(dt);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      (gameRef).showGameOverScreen();
    } else if (other is Bullet) {
      //gameRef.addBonus();
      removeFromParent();
    }
  }

}
