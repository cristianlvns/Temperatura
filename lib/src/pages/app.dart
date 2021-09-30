import 'package:flutter/material.dart';
import 'package:temperatura/src/pages/temperatura.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Temperatura(),
    );
  }
}
