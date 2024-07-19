import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../controller.dart';
import '../../components/header.dart';
import '../../constants.dart';
import '../../shared_prefs.dart';
// import '../Home/search_bar.dart';
import 'components/sale_order_screen.dart';

class SaleOrder extends StatelessWidget {
  const SaleOrder({Key? key}) : super(key: key);
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
      home: const SaleOrderScreen(),
    );
  }
}
