import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/inventory_screen.dart';

class Inventory extends StatelessWidget {
  const Inventory({Key? key}) : super(key: key);
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
      home: const InventoryScreen(),
    );
  }
}
