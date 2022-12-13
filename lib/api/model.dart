import 'dart:async';

import 'package:mobileapp/api/api_magmt.dart';

/// Class for models
class InitSession {
  String? sessionToken;
  static const String initSession = "initSession";
  static const String killSession = "killSession";
  final apiMgmt = ApiMgmt();

  InitSession();

  InitSession.core({
    this.sessionToken,
  });

  factory InitSession.fromJson(Map<String, dynamic> json) {
    return InitSession.core(
      sessionToken: json['session_token'],
    );
  }

  Future<InitSession> fetchInitSessionData() async {
    return InitSession.fromJson(await apiMgmt.authentification(initSession));
  }
}
