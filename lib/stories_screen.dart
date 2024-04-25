import 'package:flutter/material.dart';


class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Stories'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StoryWidget(),
        ],
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  final List<String> storyImages = [
    '',
    'https://picsum.photos/250?image=40',
    'https://picsum.photos/250?image=31',
    'https://picsum.photos/250?image=32',
    'https://picsum.photos/250?image=33',
  ];

  StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: storyImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryPreviewScreen(
                      storyImages: storyImages,
                      initialIndex: index,
                    ),
                  ),
                );
              },
              child: StoryItem(imageUrl: storyImages[index]),
            ),
          );
        },
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final String imageUrl;

  const StoryItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.pink,
          width: 3.0,
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: imageUrl == ""
            ? Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
              )
            : null,
      ),
    );
  }
}

class StoryPreviewScreen extends StatelessWidget {
  final List<String> storyImages;
  final int initialIndex;

  const StoryPreviewScreen({super.key, required this.storyImages, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Story Preview'),
      // ),
      body: Center(
        child: PageView.builder(
          itemCount: storyImages.length,
          controller: PageController(initialPage: initialIndex),
          itemBuilder: (context, index) {
            return Image.network(storyImages[index]);
          },
        ),
      ),
    );
  }
}