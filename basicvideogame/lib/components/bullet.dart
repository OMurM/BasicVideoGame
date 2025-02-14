import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'enemy.dart';


class Bullet extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final double speed = 300.0;

  Bullet(Vector2 position) : super(position: position, size: Vector2(10,10), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('bullet.png');
  }


}