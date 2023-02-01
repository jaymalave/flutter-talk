import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api/models/post_model.dart';
import 'dart:convert';

class PostsProvider extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> postsJson = jsonDecode(response.body);
      _posts =
          postsJson.map((dynamic postJson) => Post.fromJson(postJson)).toList();
      notifyListeners();
      return _posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<http.Response> addPost() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': 'My description',
        'body': 'My description and hey this is Jay',
        'userId': '12',
      }),
    );
    return response;
  }
}
