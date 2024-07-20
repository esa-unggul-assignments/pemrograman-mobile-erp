import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/invoice_screen.dart';

class Invoice extends StatelessWidget {
  const Invoice({Key? key}) : super(key: key);
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
      home: const InvoiceScreen(),
    );
  }
}
