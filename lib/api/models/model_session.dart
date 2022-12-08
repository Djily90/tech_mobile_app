import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Class for models
class InitSession {
  String? sessionTtoken;
  static String _url = "";
  final String _initSession = "initSession";

  InitSession();

  InitSession.core({
    this.sessionTtoken,
  });

  factory InitSession.fromJson(Map<String, dynamic> json) {
    return InitSession.core(
      sessionTtoken: json['session_token'],
    );
  }

  Future<InitSession> fetchInitSessionData(
      String url, String userToken, String appToken) async {
    InitSession._url = url;
    final response = await http
        .get(Uri.parse(getUri(_initSession)), headers: <String, String>{
      'App-token': appToken,
      'Authorization': 'user_token $userToken',
      HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8",
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return InitSession.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Ticket');
    }
  }

  String getUri(String endpoint) {
    var s = _url + endpoint;
    return s;
  }
}
