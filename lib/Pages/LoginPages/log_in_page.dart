import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ritesh_flutter_task/Models/phone_verify_model.dart';
import 'package:ritesh_flutter_task/Pages/LoginPages/otp_verify_page.dart';
import 'package:ritesh_flutter_task/Providers/phone_verify_provider.dart';
import 'dart:io';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.phone),
              label: const Text('Help'),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          Consumer<PhoneVerifyProvider>(builder: (context, value, child) {
            return Form(
              key: value.globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What's your number ?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Enter your number to proceed",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    validator: (phone) {
                      if (phone!.isEmpty || phone == null) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    controller: value.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 140),

                  // button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.grey[500]),
                          children: const [
                            TextSpan(text: 'By continuing, you agree to the'),
                            TextSpan(
                              text: ' T&C',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(text: ' and'),
                            TextSpan(
                              text: ' Privacy policy',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.0,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 1.0, 45),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          var androidInfo;
                          var androidId;
                          var device = DeviceInfoPlugin();
                          if (Platform.isAndroid) {
                            androidInfo = await device.androidInfo;
                            androidId = await androidInfo;
                            print('androidInfo : ${androidInfo.id}');
                          } else if (Platform.isIOS) {
                            var iosInfo = await device.iosInfo;
                          }
                          if (value.globalKey.currentState!.validate()) {
                            //
                            PhoneVerifyModel phoneVerifyModel =
                                PhoneVerifyModel(
                                    deviceId: '${androidInfo.id}',
                                    deviceType: 'android',
                                    deviceToken: 'sdfsdf',
                                    mobile: value.phoneController.text.trim(),
                                    adminId: '2');
                            value.phoneNumberVerify(
                              phoneVerifyModel: phoneVerifyModel,
                              onSuccess: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Loggged in successfully'),
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPVerifyPage(
                                      phoneNumber:
                                          value.phoneController.text.trim(),
                                    ),
                                  ),
                                );
                              },
                              onError: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Errort'),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: value.isLoading == true
                            ? const Center(
                                child: SizedBox(
                                height: 35,
                                width: 35,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ))
                            : const Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerifyPage(
                                phoneNumber: value.phoneController.text.trim(),
                              ),
                            ),
                          );
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  // Future<String> getUniqueDeviceId() async {
  //   String uniqueDeviceId = '';

  //   var deviceInfo = DeviceInfoPlugin();

  //   if (Platform.isIOS) {
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     uniqueDeviceId =
  //         '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
  //   } else if (Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     uniqueDeviceId = '${androidDeviceInfo.id}'; // unique ID on Android
  //   }
  //   return uniqueDeviceId;
  // }
}
