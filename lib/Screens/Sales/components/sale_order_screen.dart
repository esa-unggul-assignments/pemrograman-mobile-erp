import 'package:flutter/material.dart';
// import 'package:flutter_auth/constants.dart';
import '../../../components/header.dart';
import 'package:get/get.dart';
import 'sale_order_body.dart';

class SaleOrderScreen extends StatelessWidget {
  const SaleOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var state = Get.parameters['state'] ?? 'draft';
    var states =
        state == 'draft' ? ['draft', 'sent'] : ['sale', 'done', 'cancel'];
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: kPrimaryColor,
      //   child: const Icon(Icons.add),
      // ),
      body: Stack(
        children: <Widget>[
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(
              title: "Sale Order",
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 0,
            child: Body(title: "Sale Order", subtitle: state, states: states),
          ),
        ],
      ),
    );
  }
}
