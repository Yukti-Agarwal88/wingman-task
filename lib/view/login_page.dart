import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wingman_task/models/hive_models.dart';
import 'package:wingman_task/view/otp_verify_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();

  Map<String, dynamic> loginResponse = {};

  Future<void> postMobileNumber() async {
    var response = await dio.post(
      'https://test-otp-api.7474224.xyz/sendotp.php',
      data: {'mobile': mobileNumberController.text},
    );

    if (response.statusCode == 200) {
      var jsonResp = json.decode(response.data);
      var loginResp = HiveModels.fromJson(jsonResp);

      final loginBox = Hive.box<HiveModels>('hiveBox');
      await loginBox.add(loginResp);
    }
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
          child: Form(
            key: _formKey,
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
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 46,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter into a world, where you can transfer money without getting any fee charged.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            onChanged: (p0) {
                              mobileNumberController.text = p0;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

                              if (!phoneRegex.hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: 'Mobile Number',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.fromLTRB(10, 12, 5, 12),
                                child:
                                    //  Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.phone_android_outlined,
                                    //       color: Colors.grey[600],
                                    //     ),
                                    Text(
                                  '+ 91 ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                                //   ],
                                // ),
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
                                  // Get.to(const OtpVerification());
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, save the phone number
                                    _formKey.currentState!.save();

                                    await postMobileNumber();

                                    Get.to(() => OtpVerification(
                                          mobileNumber:
                                              mobileNumberController.text,
                                        ));
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
