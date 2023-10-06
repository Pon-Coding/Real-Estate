import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text("Hello World!"),
      ),
    );
  }
}
