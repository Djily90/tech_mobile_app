import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tech_mobile_app/api/models/model_initsession.dart';

/// Class to to connect to the API
///
class FetchInitSession {
  FetchInitSession() {
    //not used
  }

  Future<InitSession> fetchInitSessionData() async {
    final response = await http.get(
        Uri.parse('http://localhost/itsm-ng/apirest.php/initSession'),
        headers: <String, String>{
          'App-token': 'kCbXZKqbFAyAUDvm4iSBGFTyYCHR2RrJja2Ggfw3',
          'Authorization':
              'user_token TRI7fumBWp2hO215WKfGwQYeNyg66zFYVox7DD7H',
          HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8",
          /*  this parameter is used to initiate the session
           'Authorization': 'user_token token_value',
        */
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
}
