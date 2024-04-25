import 'package:flutter/material.dart';


class ItineraryTimelineTestScreen extends StatelessWidget {
  const ItineraryTimelineTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Itinerary Timeline'),
        ),
        body: Center(
          child: ItineraryTimeline(
            events: [
              Event(title: 'Event 1', time: '9:00 AM'),
              Event(title: 'Event 2', time: '11:30 AM'),
              Event(title: 'Event 3', time: '2:00 PM'),
            ],
          ),
        ),
      );
  }
}

class ItineraryTimeline extends StatefulWidget {
  final List<Event> events;

  const ItineraryTimeline({Key? key, required this.events}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ItineraryTimelineState createState() => _ItineraryTimelineState();
}

class _ItineraryTimelineState extends State<ItineraryTimeline> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0, 
      child: ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          return ItineraryTimelineItem(
            event: widget.events[index],
            animation: _controller,
            index: index,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ItineraryTimelineItem extends StatelessWidget {
  final Event event;
  final Animation<double> animation;
  final int index;

  const ItineraryTimelineItem({
    Key? key,
    required this.event,
    required this.animation,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 2.0,
                color: Colors.blue, 
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue, 
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.time,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String time;

  Event({required this.title, required this.time});
}
