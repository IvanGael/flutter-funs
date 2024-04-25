
import 'package:flutter/material.dart';

class InstagramFeedScreen extends StatelessWidget {
  InstagramFeedScreen({super.key});

  final List<String> storiesNames = [
    "gengis_kan",
    "labario_don",
    "riobueno",
    "mareror",
    "marcus_leon"
    "zabaleta",
    "derzin",
    "mayorka",
    "numelus",
    "daganus"
  ];

  final List<String> postersNames = [
    "Girtomeone",
    "Sirdane",
    "masonleo",
    "akarone",
    "Kiwiba",
    "daskito",
    "moroslone",
    "pakito",
    "okosdonton",
    "pipo_kuz",
    "katardane",
    "gentochime",
    "seater"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              // Add logic to open camera screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Add logic to open direct messages
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Stories Section
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: storiesNames.length, 
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          child: Image.asset("assets/avatar2.png"),
                          // Add user profile picture here
                        ),
                        const SizedBox(height: 4.0),
                        Text(storiesNames[index]),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Posts Section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: postersNames.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header (User info and time)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20.0,
                                child: Image.asset("assets/avatar3.png"),
                                // Add user profile picture here
                              ),
                              const SizedBox(width: 8.0),
                              Text(postersNames[index], style: const TextStyle(color: Colors.white),),
                            ],
                          ),
                          const Text('2h ago', style: TextStyle(color: Colors.white),), 
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Post Image
                      Image.network(
                        'https://picsum.photos/250?image=${index + 16}',
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8.0),
                      // Like, Comment, and Share Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  // Add logic for like button
                                },
                              ),
                              const SizedBox(width: 8.0),
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {
                                  // Add logic for comment button
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              // Add logic for share button
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}