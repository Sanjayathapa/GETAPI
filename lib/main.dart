

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'multidimension_api.dart.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserList(),
    );
  }
}
