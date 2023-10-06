import 'package:flutter/material.dart';

class SubHomeScreen extends StatelessWidget {
  static const routeName = "/sub_home_screen";
  const SubHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Home Screen"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const SubHomeScreen(),
            //   ),
            // );
            Navigator.of(context).pop();
          },
          child: const Text("Navigate"),
        ),
      ),
    );
  }
}
