import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Ticket> fetchTicket() async {
  final response = await http.get(
      Uri.parse(
          'http://addr_server/itsm-ng/apirest.php/ticket/1?expand_dropdowns=true'),
      headers: <String, String>{
        'App-token': 'App-token-value',
        'Session-token': 'Session-token-value',
        HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8",
        /*  this parameter is used to initiate the session
           'Authorization': 'user_token token_value',
        */
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Ticket.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Ticket');
  }
}

class Ticket {
  final String id;
  final String name;
  final String date;
  final String entity;

  const Ticket({
    required this.id,
    required this.name,
    required this.date,
    required this.entity,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'].toString(),
      name: json['name'],
      date: json['date'],
      entity: json['entities_id'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Ticket> futureTicket;

  @override
  void initState() {
    super.initState();
    futureTicket = fetchTicket();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Ticket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Ticket'),
        ),
        body: Center(
          child: FutureBuilder<Ticket>(
            future: futureTicket,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(snapshot.data!.id,
                        style: const TextStyle(fontSize: 20)),
                    Text(
                      snapshot.data!.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(snapshot.data!.date,
                        style: const TextStyle(fontSize: 20)),
                    Text(snapshot.data!.entity,
                        style: const TextStyle(fontSize: 20)),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
