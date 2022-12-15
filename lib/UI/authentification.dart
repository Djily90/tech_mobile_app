import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/api/model.dart';

class Authentification extends StatefulWidget {
  const Authentification({super.key});

  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final _initSession = InitSession();
  late Future<InitSession> futureSession;

  late String _url;
  late String _apiToken;
  late String _userToken;
  late bool _checkSSL = false;
  late String sessionTokenValue;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildURL() {
    return TextFormField(
      // ignore: prefer_const_constructors
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.link, color: Colors.white),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.greenAccent),
        ),
        labelText: "URL de l'API ITSM",
        labelStyle: TextStyle(color: Colors.white),
        errorStyle: TextStyle(
            color: Color.fromARGB(255, 245, 183, 177),
            fontStyle: FontStyle.italic),
      ),
      keyboardType: TextInputType.url,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return 'API URL is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _url = value.toString();
        _initSession.apiMgmt.setApiBaseUrl(_url);
      },
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildApiToken() {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.login, color: Colors.white),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          //<-- SEE HERE
          borderSide: BorderSide(width: 3, color: Colors.greenAccent),
        ),
        labelText: 'Token API de connexion',
        labelStyle: TextStyle(color: Colors.white),
        errorStyle: TextStyle(
            color: Color.fromARGB(255, 245, 183, 177),
            fontStyle: FontStyle.italic),
      ),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return 'API token is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _apiToken = value.toString();
        _initSession.apiMgmt.setApiAuthToken(_apiToken);
      },
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildUserToken() {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.white),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          //<-- SEE HERE
          borderSide: BorderSide(width: 3, color: Colors.greenAccent),
        ),
        labelText: 'Token user de connexion',
        labelStyle: TextStyle(color: Colors.white),
        errorStyle: TextStyle(
            color: Color.fromARGB(255, 245, 183, 177),
            fontStyle: FontStyle.italic),
      ),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return 'API token is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _userToken = value.toString();
        _initSession.apiMgmt.setUserToken(_userToken);
      },
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildCheckSSL() {
    return Row(
      children: <Widget>[
        Checkbox(
          fillColor: MaterialStateProperty.all(Colors.white),
          checkColor: Colors.blueAccent,
          activeColor: Colors.blueAccent,
          value: _checkSSL,
          onChanged: (bool? value) {
            setState(() {
              _checkSSL = value!;
            });
          },
        ),
        const Text(
          'Vérification du certificat SSL ',
          style: TextStyle(fontSize: 17.0, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 123, 8, 29),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("Authentification API ITSM-NG"),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 70, left: 24, top: 24, right: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/login_logo_itsm.png', width: 150),
              const SizedBox(
                height: 45,
              ),
              Expanded(
                child: _buildURL(),
              ),
              Expanded(
                child: _buildApiToken(),
              ),
              Expanded(
                child: _buildUserToken(),
              ),
              Expanded(
                child: _buildCheckSSL(),
              ),

              // ElevatedButton
              ElevatedButton(
                //MaterialButton
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 245, 183, 177), // background
                ),
                child: const Text(
                  'Valider',
                  style: TextStyle(
                      color: Color.fromARGB(255, 143, 90, 10),
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  _formKey.currentState!.save();
                  futureSession = _initSession.fetchInitSessionData();

                  getSessionValue();

                  if (kDebugMode) {
                    print(_url);
                    print(_apiToken);
                    print(_userToken);
                    print(_checkSSL);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSessionValue() async {
    FutureBuilder<InitSession>(
      future: futureSession,
      builder: (context, snapshot) {
        _initSession.apiMgmt.setApiSessionToken("gfgg");
        if (snapshot.hasData) {
          final sessionToken2 = snapshot.data!.sessionToken;
          _initSession.apiMgmt.setApiSessionToken("ffff");
          return Text(sessionToken2.toString());
        } else if (snapshot.hasError) {
          _initSession.apiMgmt.setApiSessionToken("ddd");
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
