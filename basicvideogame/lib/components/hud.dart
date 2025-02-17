import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/widgets.dart';

class Hud extends PositionComponent with HasGameRef {
  late TextComponent scoreText;
  late TextComponent nameText;
  late TextComponent difficultyText;
  int score = 0;
  String playerName;
  String difficultyLevel;

  Hud(this.playerName, this.difficultyLevel);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    nameText = TextComponent(
      text: 'Player: $playerName',
      textRenderer: TextPaint(style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24)),
    );

    scoreText = TextComponent(
      text: 'Score: $score',
      textRenderer: TextPaint(style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24)),
    );

    difficultyText = TextComponent(
      text: 'Difficulty: $difficultyLevel',
      textRenderer: TextPaint(style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24)),
    );

    add(nameText);
    add(scoreText);
    add(difficultyText);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    
    nameText.position = Vector2(20, 10);
    
    scoreText.position = Vector2((size.x - scoreText.width) / 2, 10);
    
    difficultyText.position = Vector2(size.x - difficultyText.width - 20, 10);
  }

  void updateScore(int newScore) {
    score = newScore;
    scoreText.text = 'Score: $score';
  }
}