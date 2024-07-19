import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller.dart';
import '../../../components/menu.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    final List<Map> menus = [
      {
        'name': 'Sales',
        'route': '/salesHome',
        'icon': Icons.public,
        'iconColor': Colors.red[300]
      },
      {
        'name': 'Purchase',
        'route': '/purchaseHome',
        'icon': Icons.shopping_basket,
        'iconColor': Colors.orange[300]
      },
      {
        'name': 'Accounting',
        'route': '/accountingHome',
        'icon': Icons.account_balance,
        'iconColor': Colors.purple[300]
      },
      {
        'name': 'Inventory',
        'route': '/inventoryHome',
        'icon': Icons.warehouse,
        'iconColor': Colors.blue[300]
      },
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Good Morning",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                  color: Colors.black),
            ),
            Obx(() => Text(
                  "${c.currentUser.value['name']}",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                )),
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
