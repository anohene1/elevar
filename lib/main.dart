import 'package:elevar/view/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO: Change title to suit app
      title: 'Elevar',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff0282D34),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff246CFD)),
      ),
      home: const HomePage(),
    );
  }
}

