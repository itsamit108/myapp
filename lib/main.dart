import 'package:flutter/material.dart';

import 'post_list.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pagination Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        // Simulate a loading delay
        future: Future.delayed(
          const Duration(seconds: 2),
        ),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            // Loading is done, return the app:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Flutter Pagination Demo'),
              ),
              body: const PostList(),
            );
          }
        },
      ),
    );
  }
}
