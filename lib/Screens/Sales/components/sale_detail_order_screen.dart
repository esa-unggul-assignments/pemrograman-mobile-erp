import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import '../../../components/header.dart';
import 'package:get/get.dart';
import 'sale_detail_order_body.dart';

class SaleDetailOrderScreen extends StatelessWidget {
  const SaleDetailOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var orderId = Get.parameters['id'] ?? "0";

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
              title: "Detail Order",
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 0,
            child: Body(
              title: "Detail Order $orderId",
              orderId: orderId,
            ),
          ),
        ],
      ),
    );
  }
}
