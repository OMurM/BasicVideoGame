import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef{
  Background() : super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background.png');
    size = gameRef.size;
    position = Vector2.zero();
  }
  
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
  }
}
