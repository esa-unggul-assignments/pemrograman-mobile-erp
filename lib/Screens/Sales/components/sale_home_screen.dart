import 'package:flutter/material.dart';
import '../../../components/header.dart';
import 'sale_home_body.dart';

class SalesHomeScreen extends StatelessWidget {
  const SalesHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(
              title: "Sales Menu",
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 0,
            child: Body(),
          ),
        ],
      ),
    );
  }
}
