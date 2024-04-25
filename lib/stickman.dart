import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class StickmanGameScreen extends StatelessWidget {
  const StickmanGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GameWidget(game: StickmanGame()),
    );
  }
}

class StickmanGame extends Game {
  late Stickman stickman;

  @override
  Future<void> onLoad() async {
    stickman = Stickman();
    await stickman.loadImages();
  }

  @override
  void render(Canvas canvas) {
    stickman.render(canvas);
  }

  @override
  void update(double dt) {
    stickman.update(dt);
  }
}

class Stickman extends SpriteComponent {
  late Sprite stickmanSprite;

  Future<void> loadImages() async {
    stickmanSprite = await Sprite.load('stickman.png');
    width = stickmanSprite.src.width;
    height = stickmanSprite.src.height;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (stickmanSprite != null) {
      stickmanSprite.renderRect(canvas, toRect());
    }
  }
}
