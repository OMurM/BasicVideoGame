// ignore_for_file: unused_import

import 'package:basicvideogame/components/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

class Player extends SpriteComponent 
    with KeyboardHandler, DragCallbacks, HasGameRef<MyGame> {
  Vector2 velocity = Vector2.zero();
  final double speed = 200.0;

  Player() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('player.png');
    size = Vector2(50, 50);
    angle = -3.14159 / 2;
    position = Vector2(
      gameRef.size.x - size.x - 10, 
      gameRef.size.y / 2 - size.y / 2 
    );
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    position.y = position.y.clamp(size.y / 2, gameRef.size.y - size.y / 2);
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
    return true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.y += event.localDelta.y;
    position.y = position.y.clamp(size.y / 2, gameRef.size.y - size.y / 2);
  }
}
