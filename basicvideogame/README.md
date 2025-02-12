
# Flutter 2D game

## Overview
A simple 2D game using flutter and Flame engine [text](https://flame-engine.org/)

## Features
- Player that can moves on X movments
- Collision 
- Score system on time
- Game over and restart functionality
- Simple obstacles and AI(idk so)

## Technologies Used
- **Flutter**
- **Flame**
- **Forge 2D** (optional) 

## Project Strucutre (on lib)

lib/
|    |-- main.dart          # Main entry to game
|       |-- game.dart          # Core game loop and logic
|       |-- background.dart    # Core for backround
|       |-- player.dart        # Player character and movement
|       |-- enemy.dart         # Enemy logic and behavior
|       |-- hud.dart
|       |-- game_over.dart     # Game over screen and logic
|    |-- assets/            # images, sprites, audio, sounds and others
|
|-- README.md
|-- pubspec.yaml # Dependencies and metadata


## Enunciado

Programar en Android(Flutter) un juego donde aparazcan naves de forma aleatoria desde la izquierda de la pantalla hacia la derecha. A la derecha de la pantalla se visualizará mi nave, la cual sólo se puede mover de arriba abajo, no se puede mover de derecha a izquierda. El control de mi nave se ha de poder realizar desde teclado y desde ratón. 
A medida que pase el tiempo, la velocidad de la naves de ataque aumentrá.
A la que se detecte una única colisión ha de salir la pantalla de Game over + reset game.
El juego tiene que tener sonidos diferentes. EL sonido mintras se juega y el sonido al recivir una colisión.
La primera pantalla que aparezca ha de ser aquella donde se introduzca el nombre y dos niveles de dificultad del juego. El nombre tiene que aparecer en la segunda pantalla.
Mi nave ha de poder disparar. 
El nivel de dificultad tendrá una relación directa con el núnmero de naves atacantes.
Las naves de atacantes sólo pueden dirparar de forma aleatoria en el segundo nivel.