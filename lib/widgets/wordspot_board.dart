import 'package:flutter/material.dart';
import 'package:wordspot/constants/app_color.dart';
import 'keyboard_word.dart';

class WordspotBoard extends StatefulWidget {
  const WordspotBoard({super.key});

  @override
  State<WordspotBoard> createState() => _WordspotBoardState();
}

class _WordspotBoardState extends State<WordspotBoard> {
  List<List<String>> board = List.generate(6, (_) => List.filled(5, ''));
  int currentRow = 0;
  int currentCol = 0;
  final String wordOfTheDay = 'PERRO';
  List<List<Color>> cellColors =
      List.generate(6, (_) => List.filled(5, Colors.transparent));
  List<List<Color>> borderColors =
      List.generate(6, (_) => List.filled(5, Color(0XFF757575)));
  bool gameOver = false;
  void onKeyPressed(String key) {
    if (gameOver) return;
    setState(() {
      if (key == '⌫') {
        if (currentCol > 0) {
          currentCol--;
          board[currentRow][currentCol] = '';
        }
      } else if (key == '⏎') {
        if (currentCol == 5) {
          String guessedWord = board[currentRow].join().toUpperCase();
          if (guessedWord == wordOfTheDay) {
            for (int i = 0; i < 5; i++) {
              cellColors[currentRow][i] = Colors.green;
            }
            _showMessage('¡Felicidades! Has adivinado la palabra.');
            gameOver = true;
          } else {
            _updateCellColors(guessedWord);
            if (currentRow < 5) {
              currentRow++;
              currentCol = 0;
            } else {
              _showMessage('¡Oh no! La palabra era $wordOfTheDay.');
              gameOver = true;
            }
          }
        }
      } else if (currentCol < 5) {
        board[currentRow][currentCol] = key.toUpperCase();
        currentCol++;
      }
    });
  }

  void _updateCellColors(String guessedWord) {
    List<bool> wordOfTheDayLetters = List.filled(5, false);
    List<bool> guessedWordMarked = List.filled(5, false);

    for (int i = 0; i < 5; i++) {
      if (guessedWord[i] == wordOfTheDay[i]) {
        cellColors[currentRow][i] = Colors.green;
        borderColors[currentRow][i] = Colors.green;
        wordOfTheDayLetters[i] = true;
        guessedWordMarked[i] = true;
      }
    }

    for (int i = 0; i < 5; i++) {
      if (!guessedWordMarked[i]) {
        for (int j = 0; j < 5; j++) {
          if (!wordOfTheDayLetters[j] && guessedWord[i] == wordOfTheDay[j]) {
            cellColors[currentRow][i] = Colors.orange;
            borderColors[currentRow][i] = Colors.orange;
            wordOfTheDayLetters[j] = true;
            guessedWordMarked[i] = true;
            break;
          }
        }
      }
      for (int i = 0; i < 5; i++) {
        if (!guessedWordMarked[i]) {
          cellColors[currentRow][i] = Color(0XFF757575);
          borderColors[currentRow][i] = Color(0XFF757575);
        }
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (rowIndex) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (colIndex) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: borderColors[rowIndex][colIndex]),
                            color: cellColors[rowIndex][colIndex],
                          ),
                          child: Center(
                            child: Text(
                              board[rowIndex][colIndex],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
            KeyboardWord(onKeyPressed: onKeyPressed), // Teclado personalizado
          ],
        ),
      ),
    );
  }
}
