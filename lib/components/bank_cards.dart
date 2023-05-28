import 'package:flutter/material.dart';

class BankCards extends StatelessWidget {
  const BankCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            Container(
              width: 100,
              height: 210,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(26)),
              child: Center(
                  child: Icon(
                Icons.add,
                color: Colors.blue[800],
                size: 40,
              )
                  //  Image.asset(
                  //   'name',
                  //   width: 25,
                  // ),
                  ),
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/image_card.png',
              height: 210,
            ),
            const SizedBox(
              width: 24,
            )
          ],
        ),
      ),
    );
  }
}
