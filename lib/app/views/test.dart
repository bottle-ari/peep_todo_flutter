import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: SizedBox(
        height: double.infinity,
        child: Center(
            child: Text("여기에 위젯 붙여넣기")
        ),
      ),
    );
  }
}
