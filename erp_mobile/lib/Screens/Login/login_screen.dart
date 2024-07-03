import 'package:flutter/material.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> _login(
      BuildContext context, String email, String password) async {
    final String apiUrl = dotenv.env['API_URL'] ?? 'http://10.0.2.2:8069';

    final response = await http.post(
      Uri.parse("$apiUrl/api/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    var jsonResponse = jsonDecode(response.body);

    _showResultDialog(context, jsonResponse);
  }

  void _showResultDialog(BuildContext context, dynamic response) {
    var success = response['result']['status'] == "success";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Login Successful' : 'Login Failed'),
          content: Text(success
              ? 'You have successfully logged in.'
              : 'Failed to login. Please check your credentials.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(onLogin: _login),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(onLogin: _login),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  final Function(BuildContext, String, String) onLogin;

  const MobileLoginScreen({
    Key? key,
    required this.onLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(onLogin: onLogin),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
