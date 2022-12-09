// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tech_mobile_app/api/models/model_session.dart';
import 'package:tech_mobile_app/api/api_magmt.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<InitSession> futureTicket;
  final _initSession = InitSession();
  String fullUrl = "";

  final objetApimgmt = ApiMgmt();

  String urlApi = "http://localhost/itsm-ng/apirest.php/";
  String userToken = "TRI7fumBWp2hO215WKfGwQYeNyg66zFYVox7DD7H";
  String appToken = "kCbXZKqbFAyAUDvm4iSBGFTyYCHR2RrJja2Ggfw3";

  @override
  void initState() {
    super.initState();
    _initSession.apiMgmt.setapiBaseUrl(urlApi);
    _initSession.apiMgmt.setapiAuthToken(appToken);
    _initSession.apiMgmt.setuserToken(userToken);
    futureTicket = _initSession.fetchInitSessionData();
    fullUrl = objetApimgmt.getAbsoluteUrl("initSession");
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
          child: FutureBuilder<InitSession>(
            future: futureTicket,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final sessionTtoken2 = snapshot.data!.sessionToken;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("${"Session token"}: ${sessionTtoken2}",
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
