import 'package:flutter/material.dart';
import 'package:wingman_task/components/bank_cards.dart';
import 'package:wingman_task/components/header.dart';
import 'package:wingman_task/components/recent_transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFB),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
                // color: Colors.green,
                gradient: LinearGradient(
                    colors: [Colors.blue[800]!, Colors.blue[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(50),
                )),
          ),
          ListView(
            children: const [Header(), BankCards(), Transactions()],
          )
        ],
      ),
    );
  }
}
