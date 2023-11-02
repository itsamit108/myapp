import 'package:flutter/material.dart';

import 'api_service.dart';
import 'post.dart';
import 'splash_screen.dart';

class PostDetail extends StatelessWidget {
  final int postId;

  PostDetail({required this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Post>(
      future: ApiService.fetchSinglePost(postId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(snapshot.data!.body),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return SplashScreen();
      },
    );
  }
}
