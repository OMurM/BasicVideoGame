// ignore_for_file: unused_import

import 'dart:math';
import 'package:basicvideogame/components/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'player.dart';

class Enemy extends SpriteComponent with HasGameRef, CollisionCallbacks {
  // Base speed we will increase it later
  double speed = 100;
  final Random random = Random();

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

      // Triangle hitbox simple
      final hitbox = PolygonHitbox([
      Vector2(25, 0),
      Vector2(50, 50),
      Vector2(0, 50),
    ]);

    hitbox.debugMode = true; //

    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += speed * dt;

    if (position.x > gameRef.size.x) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      (gameRef as MyGame).showGameOverScreen();
    }
  }

}
