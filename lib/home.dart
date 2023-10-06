import 'package:flutter/material.dart';
import 'package:simple_todo_app/screens/first_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
    );
  }
}
