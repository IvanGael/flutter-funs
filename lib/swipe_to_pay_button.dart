import 'package:flutter/material.dart';

class SwipeToPayButton extends StatefulWidget {
  final Function() onSwipeComplete;

  const SwipeToPayButton({Key? key, required this.onSwipeComplete}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SwipeToPayButtonState createState() => _SwipeToPayButtonState();
}

class _SwipeToPayButtonState extends State<SwipeToPayButton> {
  double _position = 0.0;
  bool _swipeComplete = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _position += details.primaryDelta!;
            if (_position > MediaQuery.of(context).size.width - 60.0) {
              _position = MediaQuery.of(context).size.width - 60.0;
              _swipeComplete = true;
            } else if (_position < 0.0) {
              _position = 0.0;
            }
          });
        },
        onHorizontalDragEnd: (details) {
          if (_swipeComplete) {
            widget.onSwipeComplete();
          } else {
            setState(() {
              _position = 0.0;
            });
          }
        },
        child: Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Positioned(
                left: _position,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    color: Colors.pink,
                    child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.swipe,
                      color: Colors.white,
                    ),
                  ),
                  ),
                ),
              ),
              const Center(
                child: Text("Swipe to pay"),
              )
            ],
          ),
        ),
      ),
    );
  }
}