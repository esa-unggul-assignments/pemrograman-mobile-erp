import 'package:flutter/material.dart';
import '../../components/header.dart';
import '../../components/menu.dart';
import '../../constants.dart';
// import '../Home/search_bar.dart';
import 'components/sale_home_screen.dart';

class SalesHome extends StatelessWidget {
  const SalesHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odoo App',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kPrimaryLightColor,
        textTheme:
            Theme.of(context).textTheme.apply(displayColor: kPrimaryColor),
      ),
      home: SalesHomeScreen(),
    );
  }
}
