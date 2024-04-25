import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class MangaReader extends StatefulWidget {
  const MangaReader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MangaReaderState createState() => _MangaReaderState();
}

class _MangaReaderState extends State<MangaReader> {
  int currentPage = 0;

  List<String> mangaPages = [
    'assets/manga1.jpg',
    'assets/manga2.jpg',
    'assets/manga3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          // Implement zoom functionality
        },
        onHorizontalDragEnd: (details) {
          // Implement swipe to change pages
          if (details.primaryVelocity! > 0 && currentPage > 0) {
            setState(() {
              currentPage--;
            });
          } else if (details.primaryVelocity! < 0 && currentPage < mangaPages.length - 1) {
            setState(() {
              currentPage++;
            });
          }
        },
        child: PhotoViewGallery.builder(
          itemCount: mangaPages.length,
          pageController: PageController(initialPage: currentPage),
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(mangaPages[index]),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}