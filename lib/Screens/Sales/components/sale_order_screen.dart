import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import '../../../components/header.dart';
import 'package:get/get.dart';
import 'sale_order_body.dart';

class SaleOrderScreen extends StatelessWidget {
  const SaleOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size * 0.5;
    var state = Get.parameters['state'] ?? 'draft';
    var states =
        state == 'draft' ? ['draft', 'sent'] : ['sale', 'done', 'cancel'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: <Widget>[
          Header(),
          Body(title: "Sale Order", subtitle: state, states: states)
        ],
      ),
    );
  }
}
