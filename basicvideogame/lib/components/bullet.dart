import 'package:basicvideogame/components/enemy.dart';
import 'package:basicvideogame/components/enemy_bullet.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class Bullet extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final double speed = 200.0;

  Bullet(Vector2 position) : super(position: position, size: Vector2(50,50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('bullet.png');

    angle = 3.14159;

    final hitbox = CircleHitbox();

    hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= speed * dt;
    if (position.x < 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      other.removeFromParent();
      removeFromParent();
    }
    if (other is EnemyBullet) {
      other.removeFromParent();
    }
  }
}