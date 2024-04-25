import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';

import 'book_page.dart';


class BookReaderScreen extends StatefulWidget {
  const BookReaderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BookReaderScreen> createState() => _FinalViewState();
}

class _FinalViewState extends State<BookReaderScreen> {
  final _controller = GlobalKey<PageFlipWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFlipWidget(
        key: _controller,
        backgroundColor: const Color.fromARGB(232, 255, 255, 255),
        initialIndex: 0,
        lastPage: Container(
            color: Colors.white,
            child: const Center(child: Text('Last Page!'))),
        children: <Widget>[
          for (var i = 0; i < 8; i++) BookPage(page: i),
        ],
      ),
    );
  }
}