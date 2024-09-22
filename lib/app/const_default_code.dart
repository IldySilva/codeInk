const defaultCode =
'''import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
''';
