
import 'package:flutter/material.dart';

class Student {
  String name;

  Student(this.name);
}

class Bench {
  List<Student> students;

  Bench({required this.students});
}

class Classroom {
  List<List<Bench>> rows;

  Classroom({required this.rows});
}

class ClassroomPainter extends CustomPainter {
  final Classroom classroom;

  ClassroomPainter(this.classroom);

  @override
  void paint(Canvas canvas, Size size) {
    final double benchWidth = size.width / 15;
    final double benchHeight = size.height / 4;
    const double studentRadius = 15;

    final Paint benchPaint = Paint()..color = Colors.brown;
    final Paint studentPaint = Paint()..color = Colors.blue;

    for (int i = 0; i < classroom.rows.length; i++) {
      for (int j = 0; j < classroom.rows[i].length; j++) {
        double benchX = j * benchWidth * 2;
        double benchY = i * benchHeight * 2;

        canvas.drawRect(
          Rect.fromPoints(
            Offset(benchX, benchY),
            Offset(benchX + benchWidth * 2, benchY + benchHeight),
          ),
          benchPaint,
        );

        for (int k = 0; k < classroom.rows[i][j].students.length; k++) {
          double studentX = benchX + k * (benchWidth / 2);
          double studentY = benchY + benchHeight / 2;

          canvas.drawCircle(
            Offset(studentX, studentY),
            studentRadius,
            studentPaint,
          );

          TextPainter(
            text: TextSpan(
              text: classroom.rows[i][j].students[k].name,
              style: const TextStyle(color: Colors.white),
            ),
            textDirection: TextDirection.ltr,
          )
            ..layout(minWidth: 0, maxWidth: benchWidth)
            ..paint(canvas, Offset(studentX - studentRadius, studentY - studentRadius));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Classroom classroom = Classroom(
      rows: List.generate(
        2,
        (i) => List.generate(
          15,
          (j) => Bench(
            students: [
              Student('SA'),
              Student('SB'),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Classroom Design'),
        ),
        body: Center(
          child: SizedBox(
            width: 600,
            height: 300,
            child: CustomPaint(
              painter: ClassroomPainter(classroom),
            ),
          ),
        ),
      );
  }
}
