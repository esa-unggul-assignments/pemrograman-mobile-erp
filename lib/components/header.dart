import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class Header extends StatelessWidget {
  final String? title;

  const Header({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: kPrimaryColor,
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.chevron_left),
              color: Colors.white,
              iconSize: 28,
              onPressed: () {
                Get.back();
              }),
          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
        ],
      ),
    );
  }
}
