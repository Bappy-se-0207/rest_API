import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Details'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            photo.url,
            width: 80,
          ),
          const SizedBox(height: 20),
          Text('Title: ${photo.title}'),
          const SizedBox(height: 10),
          Text('ID: ${photo.id}'),
        ],
      ),
    );
  }
}

class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String url;

  Photo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      url: json['url'],
    );
  }
}

Future<List<Photo>> fetchPhotos() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Photo> photos = data.map((json) => Photo.fromJson(json)).toList();
    return photos;
  } else {
    throw Exception('Failed to load photos');
  }
}
