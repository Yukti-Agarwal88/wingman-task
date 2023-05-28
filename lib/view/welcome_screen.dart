import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingman_task/boxes/box.dart';
import 'package:wingman_task/models/hive_models.dart';
import 'package:wingman_task/view/home_screen.dart';

final dio = Dio();

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? resp;
  bool? status;
  Future<void> createNewProfile() async {
    final box = Boxes.getData();
    var data = box.values.toList().cast<HiveModels>();
    dio.options.headers['Token'] = data.last.jwt;
    var response = await dio.post(
        'https://test-otp-api.7474224.xyz/profilesubmit.php',
        data: {"name": nameController.text, "email": emailController.text});

    if (response.statusCode == 200) {
      var jsonResp = json.decode(response.data);
      status = jsonResp['status'];
      resp = jsonResp['response'];
    }

    // if (status!) {
    //   Get.to(() => const HomeScreen());
    // } else {
    //   Get.snackbar(
    //    resp!,
    //     "",
    //     icon: const Icon(Icons.person, color: Colors.blue),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue[800]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.centerRight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 46,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Looks like you are new here',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an Email Address';
                              }

                              // Define the regex pattern for email validation
                              final RegExp emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }

                              return null; // Return null if the email address is valid
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: 'E-Mail',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: nameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Name';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: 'Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[800]),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await createNewProfile();
                                    status == true
                                        ? Get.to(() => const HomeScreen())
                                        : Get.snackbar(
                                            'Please try again after sometime.',
                                            resp!,
                                            icon: const Icon(
                                              Icons.info_outline_rounded,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
