import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wingman_task/boxes/box.dart';
import 'package:wingman_task/models/hive_models.dart';
import 'package:wingman_task/view/home_screen.dart';
import 'package:wingman_task/view/login_page.dart';
import 'package:wingman_task/view/welcome_screen.dart';

final dio = Dio();

class OtpVerification extends StatefulWidget {
  String mobileNumber;
  OtpVerification({super.key, required this.mobileNumber});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController otpController = TextEditingController();
  bool status = false;
  bool? newProfile;

  Future<void> verifyOtp() async {
    final box = Boxes.getData();
    var data = box.values.toList().cast<HiveModels>();

    var response = await dio.post(
        'https://test-otp-api.7474224.xyz/verifyotp.php',
        data: {"request_id": data.last.requestId, "code": otpController.text});

    var jsonResp = json.decode(response.data);
    status = jsonResp['status'];

    if (status) {
      var otpResp = HiveModels.fromJson(jsonResp);
      final loginBox = Hive.box<HiveModels>('hiveBox');
      await loginBox.add(otpResp);
      if (jsonResp['profile_exists'] != null) {
        newProfile = jsonResp['profile_exists'];
      }
    }
    // else {
    //   Get.snackbar(
    //     jsonResp['response'],
    //     "",
    //     icon: const Icon(Icons.person, color: Colors.blue),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(
                              seconds: 1,
                            ),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/eza3-Rq5rqbcGs4EkHTolm43ZXQPGH_R4GugNLGJzuo/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjk3/L2YzMDAzMWUzLTcz/MjYtNDg0ZS05MzA3/LTNkYmQ0ZGQ0ODhj/MS5zdmc.png',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/pi1hTsTcrgVklEBNOJe2TLKO2LhU6OlMoub6FCRCQ5M/rs:fit:784:666/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzAv/MzA3NzBlMGUtZTgx/YS00MTZkLWI0ZTYt/NDU1MWEzNjk4MTlh/LnN2Zw.png',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/ElwUPINwMmnzk4s2_9O31AWJhH-eRHnP9z8rHUSS5JQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzkw/Lzg2NDVlNDllLTcx/ZDItNDM1NC04YjM5/LWI0MjZkZWI4M2Zk/MS5zdmc.png',
                            ),
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        child: const Text(
                          "Verification",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        "Please enter the 6 digit code sent to \n +91 ${widget.mobileNumber}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Verification Code Input
                    FadeInDown(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 500),
                      child: PinCodeTextField(
                        controller: otpController,
                        scrollPadding: const EdgeInsets.all(4),
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 6) {
                            return 'Enter 6 digit otp';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          setState(() {});
                        },
                        errorTextSpace: 25,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        pinTheme: PinTheme(
                          inactiveFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          activeColor: Colors.black,
                          selectedFillColor: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          inactiveColor: Colors.grey.withAlpha(150),
                          selectedColor: Colors.black,
                          shape: PinCodeFieldShape.box,
                          borderWidth: 2,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 200),
                        enableActiveFill: false,
                        enablePinAutofill: true,
                        backgroundColor: Colors.transparent,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {});
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                        textStyle: const TextStyle(color: Colors.black),
                      ),

                      // child: VerificationCode(
                      //   length: 4,
                      //   textStyle:
                      //       const TextStyle(fontSize: 20, color: Colors.black),
                      //   underlineColor: Colors.black,
                      //   keyboardType: TextInputType.number,
                      //   underlineUnfocusedColor: Colors.black,
                      //   onCompleted: (value) {
                      //     setState(() {
                      //       // _code = value;
                      //     });
                      //   },
                      //   onEditing: (value) {},
                      // ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't receive the OTP?",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(const LoginPage());
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(color: Colors.blueAccent),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 500),
                      child: MaterialButton(
                        elevation: 0,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await verifyOtp();
                            status == true
                                ? newProfile == false
                                    ? Get.to(() => const WelcomeScreen())
                                    : Get.to(() => const HomeScreen())
                                : Get.snackbar(
                                    'Invalid Otp',
                                    'Retry again',
                                    icon: const Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                          }
                        },
                        color: Colors.blue[800],
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child:
                            // _isLoading
                            //     ? SizedBox(
                            //         width: 20,
                            //         height: 20,
                            //         child: const CircularProgressIndicator(
                            //           backgroundColor: Colors.white,
                            //           strokeWidth: 3,
                            //           color: Colors.black,
                            //         ),
                            //       )
                            // : _isVerified
                            //     ? const Icon(
                            //         Icons.check_circle,
                            //         color: Colors.white,
                            //         size: 30,
                            //       )
                            //     :
                            const Text(
                          "Verify",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
