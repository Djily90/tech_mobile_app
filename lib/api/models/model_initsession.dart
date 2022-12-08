
/// Class for models
class InitSession {
  final String sessionTtoken;


  const InitSession({
    required this.sessionTtoken,
 
  });

  factory InitSession.fromJson(Map<String, dynamic> json) {
    return InitSession(
      sessionTtoken: json['session_token'],
    );
  }
}
