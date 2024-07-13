import 'package:flutter/material.dart';
import 'body.dart';
import '../../../components/header.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[Header(), Body()],
      ),
    );
  }
}
