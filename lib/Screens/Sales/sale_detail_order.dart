import 'package:flutter/material.dart';
// import '../../components/header.dart';
// import '../../components/menu.dart';
import '../../constants.dart';
// import '../Home/search_bar.dart';
import 'components/sale_detail_order_screen.dart';

class SaleDetailOrder extends StatelessWidget {
  const SaleDetailOrder({Key? key}) : super(key: key);
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
      home: const SaleDetailOrderScreen(),
    );
  }
}
