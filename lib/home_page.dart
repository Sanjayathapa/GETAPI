import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Photos> photosDisplayList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

   
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosDisplayList.add(photos);
      }
      return photosDisplayList;
    } else {
      return photosDisplayList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        Expanded(
 child:FutureBuilder(
  future: getPhotos(),
  builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
     
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      
      return Text('No data available');
    } else {
     
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                'Roll No : ${snapshot.data![index].id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: _buildNetworkImage(snapshot.data![index].url.toString()),
              ),
              subtitle: Text(snapshot.data![index].title.toString()),
            ),
          );
        },
      );
    }
  },
))
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.id, required this.url});
}
ImageProvider _buildNetworkImage(String imageUrl) {
  try {
    return NetworkImage(imageUrl);
  } catch (e) {
    // Handle the error here, e.g., display a placeholder image or error message.
    print('Error loading image: $e');
    return AssetImage('assets/placeholder.png'); // Replace with your own placeholder image.
  }
}