import 'package:flutter/material.dart';
// import 'package:flutter_auth/constants.dart';
import '../../../components/header.dart';
import 'package:get/get.dart';
import 'body.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(
              title: "Inventory",
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
