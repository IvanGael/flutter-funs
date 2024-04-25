
import 'package:flutter/material.dart';

class CustomNumericalKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomNumericalKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildRow(['1', '2', '3']),
          const SizedBox(height: 10,),
          buildRow(['4', '5', '6']),
          const SizedBox(height: 10,),
          buildRow(['7', '8', '9']),
          const SizedBox(height: 10,),
          buildRow(['0', '']),
        ],
      ),
    );
  }

  Widget buildRow(List<String> keys) {
    return keys.length == 3 ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => buildKey(key)).toList(),
    ) : Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: keys.map((key) => Padding(
          padding: const EdgeInsets.only(right: 30),
          child: buildKey(key),
        )).toList(),
      ),
    );
  }

  Widget buildKey(String key) {
    return GestureDetector(
      onTap: () {
        onKeyPressed(key);
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: key.isNotEmpty
              ? Text(
                  key,
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ) : const Icon(Icons.backspace, color: Colors.white,size: 24,)
              // : Image.asset(
              //     'assets/backspace.png',
              //     color: Colors.white,
              //     width: 24.0,
              //     height: 24.0,
              //   ),
        ),
      ),
    );
  }
}
