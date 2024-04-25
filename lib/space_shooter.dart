
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SpaceShooter extends StatefulWidget {
  const SpaceShooter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpaceShooterState createState() => _SpaceShooterState();
}


class _SpaceShooterState extends State<SpaceShooter> {
  double playerX = 0;
  double playerY = 0;

  List<Offset> bullets = [];
  List<Offset> enemies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Shooter'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            playerX += details.delta.dx;
            playerY += details.delta.dy;
          });
        },
        child: Stack(
          children: [
            Positioned(
              left: playerX,
              top: playerY,
              bottom: 0,
              child: const Icon(
                Icons.airplanemode_active,
                size: 50,
                color: Colors.blue,
              ),
            ),
            for (var bullet in bullets)
              Positioned(
                left: bullet.dx,
                top: bullet.dy,
                child: const Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.red,
                ),
              ),
            for (var enemy in enemies)
              Positioned(
                left: enemy.dx,
                top: enemy.dy,
                child: const Icon(
                  Icons.airplanemode_active,
                  size: 40,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: shootMachineGun,
        child: const Icon(Icons.aod),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    const duration = Duration(milliseconds: 100);
    Timer.periodic(duration, (timer) {
      moveBullets();
      moveEnemies();
      checkCollisions();
    });

    Timer.periodic(const Duration(seconds: 2), (timer) {
      spawnEnemy();
    });
  }

  void moveBullets() {
    setState(() {
      bullets = bullets
          .map((bullet) => Offset(bullet.dx, bullet.dy - 20))
          .toList();
      bullets.removeWhere((bullet) => bullet.dy < 0);
    });
  }

  void moveEnemies() {
    setState(() {
      enemies = enemies
          .map((enemy) => Offset(enemy.dx, enemy.dy + 5))
          .toList();
      enemies.removeWhere((enemy) => enemy.dy > MediaQuery.of(context).size.height);
    });
  }

  void checkCollisions() {
    for (var enemy in enemies) {
      for (var bullet in bullets) {
        if (enemy.dx - bullet.dx.abs() < 50 && enemy.dy - bullet.dy.abs() < 50) {
          setState(() {
            enemies.remove(enemy);
            bullets.remove(bullet);
          });
        }
      }
    }
  }

  void spawnEnemy() {
    setState(() {
      enemies.add(Offset(Random().nextInt(300).toDouble(), 0));
    });
  }

  void shootMachineGun() {
    setState(() {
      bullets.add(Offset(playerX + 20, playerY));
      bullets.add(Offset(playerX - 20, playerY));
      bullets.add(Offset(playerX, playerY - 20));
    });
  }
}
