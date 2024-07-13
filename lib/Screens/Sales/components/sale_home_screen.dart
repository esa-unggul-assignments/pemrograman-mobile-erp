import 'package:flutter/material.dart';
import '../../../components/header.dart';
import 'sale_home_body.dart';

class SalesHomeScreen extends StatelessWidget {
  const SalesHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size * 0.5;
    return Scaffold(
      body: Stack(
        children: <Widget>[Header(), Body(title: "Sales Menu")],
      ),
    );
  }
}
