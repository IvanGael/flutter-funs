// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';




class GalleryImagesScreen extends StatefulWidget {
  const GalleryImagesScreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GalleryImagesScreen> {
  final String apiKey = 'UlCIE2ej4-bM_b_mD8LVZCkcc2CII75iLZhXNrPVRh8';
  List<dynamic> photos = [];
  // List<Map<String, Uint8List?>> photos = [];
  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    // SharedPreferences.getInstance()
    // .then((pref) => {
    //   pref.clear()
    // });
    fetchPhotos();
  }

  // Future<Uint8List?> networkImageToUint8List(String imageUrl) async {
  //   try {
  //     // Fetch the image from the network
  //     final response = await http.get(Uri.parse(imageUrl));
  //     if (response.statusCode == 200) {
  //       // Convert the response body to Uint8List
  //       return response.bodyBytes;
  //     } else {
  //       // If the server returns an error response, throw an exception
  //       throw Exception('Failed to load image: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle any errors that occurred during the process
  //     print('Error: $e');
  //     return null;
  //   }
  // }


  // Future<void> fetchPhotos() async {
  //   setState(() {
  //     isFetching = true;
  //   });

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final cachedPhotos = prefs.getString('cachedPhotos');

  //   if (cachedPhotos != null) {
  //     final List<dynamic> cachedPhotosList = json.decode(cachedPhotos);
  //     final List<Map<String, Uint8List?>> convertedPhotos = [];
  //     for (final photo in cachedPhotosList) {
  //       final smallImage = await networkImageToUint8List(photo['urls']['small']);
  //       final fullImage = await networkImageToUint8List(photo['urls']['full']);
  //       final Map<String, Uint8List?> convertedPhoto = {
  //         'small': smallImage,
  //         'full': fullImage,
  //       };
  //       convertedPhotos.add(convertedPhoto);
  //     }
  //     setState(() {
  //       photos = convertedPhotos;
  //       isFetching = false;
  //     });
  //   } else {
  //     final response = await http.get(
  //       Uri.parse('https://api.unsplash.com/photos/random/?count=30'),
  //       headers: {'Authorization': 'Client-ID $apiKey'},
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> fetchedPhotos = json.decode(response.body);
  //       final List<Map<String, Uint8List?>> convertedPhotos = [];
  //       for (final photo in fetchedPhotos) {
  //         final smallImage = await networkImageToUint8List(photo['urls']['small']);
  //         final fullImage = await networkImageToUint8List(photo['urls']['full']);
  //         final Map<String, Uint8List?> convertedPhoto = {
  //           'small': smallImage,
  //           'full': fullImage,
  //         };
  //         convertedPhotos.add(convertedPhoto);
  //       }
  //       setState(() {
  //         photos = convertedPhotos;
  //         isFetching = false;
  //       });
  //       prefs.setString('cachedPhotos', response.body);
  //     } else {
  //       setState(() {
  //         isFetching = false;
  //       });
  //       throw Exception('Failed to load photos');
  //     }
  //   }

  // }

  
  Future<void> fetchPhotos() async {
    setState(() {
      isFetching = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedPhotos = prefs.getString('cachedPhotos');

    if (cachedPhotos != null) {
      await Future.delayed(const Duration(seconds: 12), (){
        setState(() {
        photos = json.decode(cachedPhotos);
        isFetching = false;
      });
      });
    } else {
      final response = await http.get(
        Uri.parse('https://api.unsplash.com/photos/random/?count=30'),
        headers: {'Authorization': 'Client-ID $apiKey'},
      );

      if (response.statusCode == 200) {
        setState(() {
          isFetching = false;
          photos = json.decode(response.body);
        });
        prefs.setString('cachedPhotos', response.body);
      } else {
        setState(() {
          isFetching = false;
        });
        throw Exception('Failed to load photos');
      }
    }

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isFetching
          ? const ShimmerGridView() 
          : SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  photos.length,
                  (index) => GestureDetector(
                    onTap: isFetching == true ? null : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(photo: photos[index]),
                        ),
                      );
                    },
                    child: Image.network(
                      photos[index]['urls']['small'],
                      fit: BoxFit.cover
                    ),
                    // child: Image.memory(
                    //   photos[index]['small']!,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
            ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final dynamic photo;

  const DetailScreen({super.key, required this.photo});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool showImage = false;

  @override
  void initState() {
    super.initState();
    waitToShowImage();
  }

  waitToShowImage() async {
    await Future.delayed(const Duration(seconds: 18), (){
      setState(() {
        showImage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.photo['alt_description'],
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        elevation: 8,
        shadowColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (){
            Navigator.pop(context);
          }, 
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,)
          ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Image.network(
          widget.photo['urls']['full'],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, widget, imageChunkEvent){
            return showImage == false
            ? const Center(
              child: SizedBox(
                width: 50, 
                height: 50,
                child: CircularProgressIndicator(color: Colors.greenAccent,)
                ),
                ) : widget;
          },
        )
      // body: Image.memory(
      //                 widget.photo['urls']['full']!,
      //                 fit: BoxFit.cover,
      //                 width: double.infinity,
      //                 height: double.infinity
      //               ),
      // Hero(
      //   tag: widget.photo['id'],
      //   // child: CachedNetworkImage(
      //   //   imageUrl: photo['urls']['full'],
      //   //   fit: BoxFit.cover,
      //   //   height: double.infinity,
      //   //   width: double.infinity,
      //   //   alignment: Alignment.center
      //   // ),
      //   child: Image.network(
      //     widget.photo['urls']['full'],
      //     fit: BoxFit.cover,
      //     width: double.infinity,
      //     height: double.infinity,
      //   ),
        
      // ),
    );
  }
}



class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(
          30,
          (index) => Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}