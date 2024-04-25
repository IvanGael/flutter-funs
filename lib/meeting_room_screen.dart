
import 'package:flutter/material.dart';

class MeetRoomScreen extends StatelessWidget {
  const MeetRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Implement user profile or settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                'Upcoming Meetings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Replace the below list with your actual upcoming meetings data
            ListTile(
              title: const Text('Team Standup Meeting'),
              subtitle: const Text('10:00 AM - 11:00 AM'),
              onTap: () {
                // Implement the action when tapping on the meeting
              },
            ),
            ListTile(
              title: const Text('Design Review'),
              subtitle: const Text('2:00 PM - 3:00 PM'),
              onTap: () {
                // Implement the action when tapping on the meeting
              },
            ),
            // Add more upcoming meetings as needed

            // Add a divider between upcoming and previous meetings
            const Divider(),

            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.green,
              child: const Text(
                'Previous Meetings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Replace the below list with your actual previous meetings data
            ListTile(
              title: const Text('Project Kickoff'),
              subtitle: const Text('Recorded on 2024-02-10'),
              onTap: () {
                // Implement the action when tapping on the meeting
              },
            ),
            ListTile(
              title: const Text('Weekly Sync'),
              subtitle: const Text('Recorded on 2024-02-07'),
              onTap: () {
                // Implement the action when tapping on the meeting
              },
            ),
            // Add more previous meetings as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement the action for creating a new meeting
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}




// class MeetRoomScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Meet Room'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {
//               // Implement user profile or settings
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Upcoming Meetings',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 5, // Replace with the actual number of upcoming meetings
//                 itemBuilder: (context, index) {
//                   return MeetingCard(
//                     title: 'Meeting $index',
//                     time: '10:00 AM - 11:00 AM',
//                     onTap: () {
//                       // Implement the action when tapping on the meeting
//                     },
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Previous Meetings',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 5, // Replace with the actual number of previous meetings
//                 itemBuilder: (context, index) {
//                   return MeetingCard(
//                     title: 'Meeting $index',
//                     time: 'Recorded on 2024-02-10',
//                     onTap: () {
//                       // Implement the action when tapping on the meeting
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement the action for creating a new meeting
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class MeetingCard extends StatelessWidget {
//   final String title;
//   final String time;
//   final VoidCallback onTap;

//   const MeetingCard({
//     Key? key,
//     required this.title,
//     required this.time,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.only(bottom: 16),
//       child: ListTile(
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(time),
//         onTap: onTap,
//         contentPadding: EdgeInsets.all(16),
//       ),
//     );
//   }
// }