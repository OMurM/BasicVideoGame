import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'enemy.dart';
import 'bullet.dart';

class EnemyBullet extends SpriteComponent with HasGameRef, CollisionCallbacks { 
  final double speed = 200.0;

  EnemyBullet(Vector2 position) : super(position: position, size: Vector2(50, 50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('bullet.png');

    angle = 0;

    final hitbox = CircleHitbox();

    hitbox.debugMode = true;
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
      if (other is Enemy) {
        return;
      }
      if (other is Bullet) {
        other.removeFromParent();
      }
      removeFromParent();
    }
  }