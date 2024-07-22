import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';
// import "controller.dart";
import 'Screens/Home/home.dart';
import 'Screens/Sales/sale_home.dart';
import 'Screens/Sales/sale_order.dart';
import 'Screens/Sales/sale_detail_order.dart';
import 'Screens/Customers/sale_customers.dart';
import 'Screens/Delivery/delivery.dart';
import 'Screens/Purchase/purchase.dart';
import 'Screens/Inventory/inventory.dart';
import 'Screens/Invoice/invoice.dart';
import 'Screens/Accounting/accounting.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        home: const WelcomeScreen(),
        getPages: [
          GetPage(name: '/home', page: () => const Home()),
          GetPage(name: '/salesHome', page: () => const SalesHome()),
          GetPage(name: '/saleOrder/:state', page: () => const SaleOrder()),
          GetPage(
              name: '/saleOrderView/:id', page: () => const SaleDetailOrder()),
          GetPage(name: '/partner/customer', page: () => const SaleCustomers()),
          GetPage(name: '/picking/delivery', page: () => const Delivery()),
          GetPage(name: '/purchaseHome', page: () => const Purchase()),
          GetPage(name: '/inventoryHome', page: () => const Inventory()),
          GetPage(name: '/invoice/customer', page: () => const Invoice()),
          GetPage(name: '/accountingHome', page: () => const Accounting()),
        ]);
  }
}
