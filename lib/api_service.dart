import 'dart:convert';

import 'package:http/http.dart' as http;

import 'post.dart';

class ApiService {
  static Future<List<Post>> fetchPosts(int page) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<Post> fetchSinglePost(int id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
