import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    Widget transactionCard(
        {required String title,
        required String subtitle,
        required double amount}) {
      return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xff616F80),
              fontSize: 12,
            ),
          ),
          trailing: Text(
            '₹ $amount',
            style: TextStyle(
              color: amount < 0 ? Colors.red : Colors.green,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transactions',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 12,
          ),
          transactionCard(
              title: 'Paid to Rahul',
              subtitle: 'Today, 10:00PM',
              amount: -19000),
          transactionCard(
              title: 'Received from Raj',
              subtitle: 'Today, 9:15AM',
              amount: 9000),
          transactionCard(
              title: 'Received from XYZ',
              subtitle: 'Yesterday, 11:05PM',
              amount: 5000),
          transactionCard(
              title: 'Paid to ABC',
              subtitle: 'Yesterday, 12:30PM',
              amount: -3000),
          transactionCard(
              title: 'Paid to Rizz',
              subtitle: '25th May, 2023, 9:30PM',
              amount: -10000),
          transactionCard(
              title: 'Received from Rahul',
              subtitle: '23rd May, 2023, 2:30PM',
              amount: 20000),
        ],
      ),
    );
  }
}
