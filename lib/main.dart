import 'package:flutter/material.dart';
import 'home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white.withOpacity(0.8),
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 10.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
