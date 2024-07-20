import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/purchase_screen.dart';

class Purchase extends StatelessWidget {
  const Purchase({Key? key}) : super(key: key);
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
      home: const PurchaseScreen(),
    );
  }
}
