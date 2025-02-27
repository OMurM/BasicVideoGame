// ignore_for_file: unused_import

import 'package:basicvideogame/components/bullet.dart';
import 'package:basicvideogame/components/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'enemy.dart';

class Player extends SpriteComponent 
    with KeyboardHandler, DragCallbacks, HasGameRef<MyGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  final double speed = 200.0;

  Player() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('player.png');
    size = Vector2(50, 50);
    angle = -3.14159 / 2;
    position = Vector2(
      gameRef.size.x - size.x - 10, 
      gameRef.size.y / 2 - size.y / 2 
    );

    final hitbox = PolygonHitbox([
      Vector2(25, 0),
      Vector2(50, 35),
      Vector2(0, 35),
    ]);

    hitbox.debugMode = false;

    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    position.y = position.y.clamp(size.y / 2, gameRef.size.y - size.y / 2);
  }

  void shoot() {
    final bullet = Bullet(position.clone());
    gameRef.add(bullet);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      velocity.y = -speed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      velocity.y = speed;
    } else {
      velocity.y = 0;
    }

    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      shoot();
    }
    return true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.y += event.localDelta.y;
    position.y = position.y.clamp(size.y / 2, gameRef.size.y - size.y / 2);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.showGameOverScreen();
    }
  }
}