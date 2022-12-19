import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiMgmt {
  String? apiBaseUrl;
  String? apiAuthToken;
  String? apiSessionToken;
  String? userToken;
  bool checkSSL = false;
  bool authStatus = false;
  final String headerType = "application/json;charset=UTF-8";

  ApiMgmt();

  dynamic get(String relativeUrl) async {
    final response = await http
        .get(Uri.parse(getAbsoluteUrl(relativeUrl)), headers: <String, String>{
      'App-token': apiAuthToken.toString(),
      'Session-token': apiSessionToken.toString(),
      HttpHeaders.contentTypeHeader: headerType,
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      authStatus = true;
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      authStatus = false;
      throw Exception("Failed to get data from the endpoind $relativeUrl");
    }
  }

  dynamic authentification(String relativeUrl) async {
    final response = await http
        .get(Uri.parse(getAbsoluteUrl(relativeUrl)), headers: <String, String>{
      'App-token': apiAuthToken.toString(),
      'Authorization': "${"user_token"} $userToken",
      HttpHeaders.contentTypeHeader: headerType,
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      authStatus = true;

      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      authStatus = false;
      return {
        "Session-token": null,
      };
    }
  }

  void logoutFromItsmAPI(String relativeUrl) async {
    final response = await http
        .get(Uri.parse(getAbsoluteUrl(relativeUrl)), headers: <String, String>{
      'App-token': apiAuthToken.toString(),
      'Session-token': apiSessionToken.toString(),
      HttpHeaders.contentTypeHeader: headerType,
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      authStatus = false;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to kill the session');
    }
  }

  // return the the url with API url + endpoind as parameter
  String getAbsoluteUrl(String endpoint) {
    final String uri = apiBaseUrl.toString() + endpoint;
    return uri;
  }

  void setApiSessionToken(String sessionToken) {
    apiSessionToken = sessionToken;
  }

  void setApiBaseUrl(String apiBaseUrl) {
    this.apiBaseUrl = apiBaseUrl;
  }

  void setApiAuthToken(String apiAuthToken) {
    this.apiAuthToken = apiAuthToken;
  }

  void setUserToken(String userToken) {
    this.userToken = userToken;
  }
  void setCheckSSL(bool checkSSL) {
    this.checkSSL = checkSSL;
  }
}
