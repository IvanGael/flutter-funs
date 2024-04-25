import 'package:flutter/material.dart';


class CustomStaggeredGridView extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;
  final List<StaggeredTile> staggeredTiles;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const CustomStaggeredGridView({super.key, 
    required this.crossAxisCount,
    required this.children,
    required this.staggeredTiles,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}

class StaggeredTile {
  final int crossAxisCellCount;
  final int mainAxisCellCount;

  StaggeredTile({required this.crossAxisCellCount, required this.mainAxisCellCount});

  factory StaggeredTile.count(int crossAxisCellCount, int mainAxisCellCount) {
    return StaggeredTile(crossAxisCellCount: crossAxisCellCount, mainAxisCellCount: mainAxisCellCount);
  }
}

class CinemaTicketBookingScreen extends StatefulWidget {
  const CinemaTicketBookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TicketBookingScreenState createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<CinemaTicketBookingScreen> {
  List<Seat> seats = List.generate(30, (index) => Seat(index + 1, false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Seats:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomStaggeredGridView(
                crossAxisCount: 6,
                staggeredTiles: seats.map((seat) {
                  return StaggeredTile.count(2, seat.number.isEven ? 2 : 1);
                }).toList(),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: seats.map((seat) {
                  return SeatWidget(
                    seat: seat,
                    onTap: () {
                      setState(() {
                        seat.isSelected = !seat.isSelected;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your booking logic here
                // For example, you can navigate to the payment screen
                List<int> selectedSeatNumbers = seats
                    .where((seat) => seat.isSelected)
                    .map((seat) => seat.number)
                    .toList();

                // print('Selected Seats: $selectedSeatNumbers');
              },
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class Seat {
  final int number;
  bool isSelected;

  Seat(this.number, this.isSelected);
}

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatWidget({super.key, required this.seat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: seat.isSelected ? Colors.pink : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            seat.number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}