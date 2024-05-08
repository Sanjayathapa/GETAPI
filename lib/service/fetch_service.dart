import 'dart:convert';

import '../model/model.dart';
import 'package:http/http.dart' as http;
Future<List<User>> fetchUsers() async {
  try {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
  
    throw Exception('Failed to fetch data: $e');
  }
}