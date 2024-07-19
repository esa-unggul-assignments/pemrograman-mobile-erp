import 'package:flutter/material.dart';
import '../../../components/header.dart';
import 'sale_customer_body.dart';

class SaleCustomerScreen extends StatelessWidget {
  const SaleCustomerScreen({Key? key}) : super(key: key);
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
              title: "Customers",
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
