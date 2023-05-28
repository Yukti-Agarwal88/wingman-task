import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wingman_task/view/login_page.dart';

import '../models/hive_models.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Featured Card',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () {
                  Hive.box<HiveModels>('hiveBox').clear();
                  Get.to(const LoginPage());
                },
                child: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                  size: 26.0,
                ),
              )
            ],
          ),
          const Text(
            'Available 12 items',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
