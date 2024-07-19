import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import "../../controller.dart";
// import '../../components/header.dart';
// import '../../components/menu.dart';
import '../../constants.dart';
import '../../shared_prefs.dart';
// import 'search_bar.dart';
import 'components/home_screen.dart';

final Controller c = Get.find();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void getUsers(context) async {
      final prefs = SharedPref();
      final sobj = await prefs.readObject('session');
      var baseUrl = await prefs.readString('baseUrl');
      final session = OdooSession.fromJson(sobj);
      final client = OdooClient(baseUrl, session);
      try {
        var res = await client.callKw({
          'model': 'res.users',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'context': {'bin_size': true},
            'domain': [
              ['id', '=', session.userId]
            ],
            'fields': ['id', 'name'],
          },
        });
        print(res);
        c.setCurrentUser(res[0]);
      } catch (e) {
        client.close();
        print(e.toString());
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return SimpleDialog(
        //           children: <Widget>[Center(child: Text(e.toString()))]);
        //     });
      }
    }

    getUsers(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odoo App',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kPrimaryLightColor,
        textTheme:
            Theme.of(context).textTheme.apply(displayColor: kPrimaryColor),
      ),
      home: HomeScreen(),
    );
  }
}
