//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:mobileapp/UI/authentification.dart';
import 'package:mobileapp/UI/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: const Color.fromARGB(255, 254, 255, 255),
        ),
        home: const HomePage());
  }
}
