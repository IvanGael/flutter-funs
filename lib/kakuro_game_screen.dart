import 'package:flutter/material.dart';

class KakuroCell {
  int? value;
  int? sumAcross;
  int? sumDown;

  KakuroCell({this.value, this.sumAcross, this.sumDown});
}

class KakuroGame {
  List<List<KakuroCell>> grid;

  KakuroGame(this.grid);
}

class KakuroGameScreen extends StatefulWidget {
  const KakuroGameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KakuroScreenState createState() => _KakuroScreenState();
}

class _KakuroScreenState extends State<KakuroGameScreen> {
  KakuroGame kakuroGame = KakuroGame([
    [
      KakuroCell(sumDown: 6),
      KakuroCell(),
      KakuroCell(),
      KakuroCell(sumDown: 15)
    ],
    [KakuroCell(), KakuroCell(), KakuroCell(), KakuroCell()],
    [
      KakuroCell(),
      KakuroCell(),
      KakuroCell(sumAcross: 3, sumDown: 15),
      KakuroCell()
    ],
    [KakuroCell(sumAcross: 6), KakuroCell(), KakuroCell(), KakuroCell()]
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kakuro Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kakuro Grid',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildKakuroGrid(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                checkCorrectness();
              },
              child: const Text('Check Correctness'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKakuroGrid() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(),
        children: kakuroGame.grid.asMap().entries.map((rowEntry) {
          int rowIndex = rowEntry.key;
          List<KakuroCell> row = rowEntry.value;

          return TableRow(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            children: row.asMap().entries.map((cellEntry) {
              int colIndex = cellEntry.key;
              KakuroCell cell = cellEntry.value;

              return buildCell(rowIndex, colIndex, cell);
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget buildCell(int rowIndex, int colIndex, KakuroCell cell) {
    return GestureDetector(
      onTap: () {
        if (cell.value == null) {
          showNumberPickerDialog(rowIndex, colIndex);
        }
      },
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Text(
          cell.value != null ? cell.value.toString() : '',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  void showNumberPickerDialog(int rowIndex, int colIndex) {
    int? selectedNumber;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a number'),
          content: Column(
            children: List.generate(9, (index) {
              return GestureDetector(
                onTap: () {
                  selectedNumber = index + 1;
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ),
        );
      },
    ).then((value) {
      if (selectedNumber != null) {
        setState(() {
          kakuroGame.grid[rowIndex][colIndex].value = selectedNumber;
        });
      }
    });
  }

  void checkCorrectness() {
    bool isCorrect = true;

    // Check correctness for rows
    for (int rowIndex = 0; rowIndex < kakuroGame.grid.length; rowIndex++) {
      int rowSum = 0;
      for (int colIndex = 0;
          colIndex < kakuroGame.grid[rowIndex].length;
          colIndex++) {
        if (kakuroGame.grid[rowIndex][colIndex].value != null) {
          rowSum += kakuroGame.grid[rowIndex][colIndex].value!;
        }
      }
      if (kakuroGame.grid[rowIndex][0].sumAcross != null &&
          rowSum != kakuroGame.grid[rowIndex][0].sumAcross) {
        isCorrect = false;
        break;
      }
    }

    // Check correctness for columns
    for (int colIndex = 0; colIndex < kakuroGame.grid[0].length; colIndex++) {
      int colSum = 0;
      for (int rowIndex = 0; rowIndex < kakuroGame.grid.length; rowIndex++) {
        if (kakuroGame.grid[rowIndex][colIndex].value != null) {
          colSum += kakuroGame.grid[rowIndex][colIndex].value!;
        }
      }
      if (kakuroGame.grid[0][colIndex].sumDown != null &&
          colSum != kakuroGame.grid[0][colIndex].sumDown) {
        isCorrect = false;
        break;
      }
    }

    // Show dialog indicating correctness
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Status'),
          content: Text(isCorrect
              ? 'Correct! Well done!'
              : 'Incorrect. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
