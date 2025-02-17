import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedDifficulty = 'Easy';

  void _startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          playerName: _nameController.text,
          difficultyLevel: _selectedDifficulty,
        ),
      ),
    );
  }

  void _exitGame() {
    SystemNavigator.pop(animated: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select Difficulty'),
            DropdownButton<String>(
              value: _selectedDifficulty,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDifficulty = newValue!;
                });
              },
              items: <String>['Easy', 'Hard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _exitGame,
              child: const Text('Exit Game'),
            ),
          ],
        ),
      ),
    );
  }
}