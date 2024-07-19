import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridMenu extends StatelessWidget {
  final List<Map> menus;

  const GridMenu({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.0,
      ),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final menu = menus[index];
        return GestureDetector(
          onTap: () {
            print("go to route $menu['route']");
            Get.toNamed(menu['route']);
          },
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  menu['icon'],
                  size: 48.0,
                  color: menu['iconColor'],
                ),
                const SizedBox(height: 16.0),
                Text(
                  menu['name'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
