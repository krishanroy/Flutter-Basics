import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_basics/Photo.dart';
import 'package:http/http.dart' as http;

class PhotosListPage extends StatelessWidget {
  const PhotosListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: FutureBuilder<Iterable<Photo>>(
        future: _getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final Iterable<Photo> photos;

  const PhotosList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos.toList()[index].thumbnailUrl);
      },
    );
  }
}

Future<Iterable<Photo>> _getPhotos() async {
  final url = Uri.https('jsonplaceholder.typicode.com', '/photos');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final photosList = (jsonDecode(response.body) as List).map((model) => Photo.fromJson(model));
    return photosList;
  } else {
    throw Exception('Failed to load User');
  }
}
