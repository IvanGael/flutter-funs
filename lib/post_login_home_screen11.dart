
import 'package:flutter/material.dart';

class PostLoginHomeScreen11 extends StatelessWidget {
  const PostLoginHomeScreen11({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const Hero(
            tag: 'app_title',
            child: Material(
              color: Colors.transparent,
              child: Text(
                'Hero Animation Home Screen',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'app_logo',
          child: Container(
            height: 150.0,
            width: 150.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
            child: const Icon(
              Icons.star,
              size: 80.0,
              color: Colors.amber,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the main action
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}