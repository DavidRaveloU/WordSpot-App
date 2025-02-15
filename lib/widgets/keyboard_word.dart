import 'package:flutter/material.dart';

class KeyboardWord extends StatelessWidget {
  final Function(String) onKeyPressed;
  const KeyboardWord({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']
                .map((letter) {
              return KeyboardButton(
                letter: letter,
                onPressed: () => onKeyPressed(letter),
              );
            }).toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'].map((letter) {
            return KeyboardButton(
              letter: letter,
              onPressed: () => onKeyPressed(letter),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyboardButton(
              letter: '⏎',
              onPressed: () => onKeyPressed('⏎'),
              doubleSize: true,
            ),
            ...'ZXCVBNM'.split('').map((letter) {
              return KeyboardButton(
                letter: letter,
                onPressed: () => onKeyPressed(letter),
              );
            }),
            KeyboardButton(
              letter: '⌫',
              onPressed: () => onKeyPressed('⌫'),
              doubleSize: true,
            ),
          ],
        )
      ],
    );
  }
}

class KeyboardButton extends StatelessWidget {
  final String letter;
  final bool? doubleSize;
  final VoidCallback onPressed;

  const KeyboardButton({
    required this.letter,
    required this.onPressed,
    super.key,
    this.doubleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Color(0xFF3F4752),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: doubleSize == true ? 45 : 30,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
