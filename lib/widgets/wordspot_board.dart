import 'package:flutter/material.dart';

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

  void onKeyPressed(String key) {
    setState(() {
      if (key == '⌫') {
        if (currentCol > 0) {
          currentCol--;
          board[currentRow][currentCol] = '';
        }
      } else if (key == '⏎') {
        if (currentCol == 5) {
          currentRow++;
          currentCol = 0;
        }
      } else if (currentCol < 5) {
        board[currentRow][currentCol] = key;
        currentCol++;
      }
    });
  }

  void updateCell(int row, int col, String letter) {
    setState(() {
      board[row][col] = letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (rowIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (colIndex) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(board[rowIndex][colIndex]),
                      ),
                    );
                  }),
                );
              })),
        ),
      ),
      KeyboardWord(onKeyPressed: onKeyPressed),
    ]));
  }
}
