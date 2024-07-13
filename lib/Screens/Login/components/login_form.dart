import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import "../../../shared_prefs.dart";

final _usernameController =
    TextEditingController(text: 'robbani.jihad@student.esaunggul.ac.id');
final _passwordController = TextEditingController();

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _doLogin(context) async {
      const baseUrl = 'http://10.0.2.2:8069';
      const db = 'dberp14';
      final client = OdooClient(baseUrl);
      try {
        final session = await client.authenticate(
            db, _usernameController.text, _passwordController.text);
        final prefs = SharedPref();
        prefs.saveObject('session', session);
        prefs.saveString('baseUrl', baseUrl);
        prefs.saveString('db', db);
        print("logged in");
        print(session);
        Get.toNamed("/home");
      } on Exception catch (e) {
        client.close();
        print(e.toString());
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                  children: <Widget>[Center(child: Text(e.toString()))]);
            });
      }
      client.close();
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              _doLogin(context);
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
