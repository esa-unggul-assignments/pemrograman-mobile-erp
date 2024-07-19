import 'package:flutter/material.dart';
import '../../../components/menu.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Map> menus = [
      {
        'name': 'Quotation',
        'route': '/saleOrder/draft',
        'icon': Icons.public,
        'iconColor': Colors.red[300]
      },
      {
        'name': 'Sale Order',
        'route': '/saleOrder/confirmed',
        'icon': Icons.shopping_basket,
        'iconColor': Colors.orange[300]
      },
      {
        'name': 'Customers',
        'route': '/partner/customer',
        'icon': Icons.account_balance,
        'iconColor': Colors.purple[300]
      },
      {
        'name': 'Delivery',
        'route': '/picking/delivery',
        'icon': Icons.warehouse,
        'iconColor': Colors.blue[300]
      },
      {
        'name': 'Invoices',
        'route': '/invoice/customer',
        'icon': Icons.money,
        'iconColor': Colors.green[300]
      },
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SearchBar(),
            Expanded(
              child: GridMenu(menus: menus),
            ),
          ],
        ),
      ),
    );
  }
}
