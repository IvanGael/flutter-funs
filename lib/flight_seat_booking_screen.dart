
import 'package:flutter/material.dart';

class FlightSeatBookingScreen extends StatefulWidget {
  const FlightSeatBookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlightSeatBookingScreenState createState() => _FlightSeatBookingScreenState();
}

class _FlightSeatBookingScreenState extends State<FlightSeatBookingScreen> {
  List<String> selectedSeats = [];

  void _onSeatSelected(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select your seat(s)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SeatGrid(
                onSeatSelected: _onSeatSelected,
                selectedSeats: selectedSeats,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your logic for booking seats
                // print('Selected Seats: $selectedSeats');
              },
              child: const Text('Book Seats'),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatGrid extends StatelessWidget {
  final List<String> selectedSeats;
  final Function(String) onSeatSelected;

  const SeatGrid({super.key, required this.selectedSeats, required this.onSeatSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 36,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String seat = 'Seat ${(index + 1)}';
        return GestureDetector(
          onTap: () => onSeatSelected(seat),
          child: SeatWidget(
            seatNumber: seat,
            isSelected: selectedSeats.contains(seat),
          ),
        );
      },
    );
  }
}

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final bool isSelected;

  const SeatWidget({super.key, required this.seatNumber, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SeatPainter(isSelected: isSelected),
      child: Center(
        child: Text(
          seatNumber,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SeatPainter extends CustomPainter {
  final bool isSelected;

  SeatPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = isSelected ? Colors.blue : Colors.grey[300]!;
    paint.style = PaintingStyle.fill;

    double radius = size.width / 2;

    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}