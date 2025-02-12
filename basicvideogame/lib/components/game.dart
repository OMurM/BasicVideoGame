// ignore_for_file: unused_import

import 'package:flame/game.dart';
import 'background.dart';
import 'player.dart';
import 'package:flame/input.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(Background());
    add(Player());
  }
}
