import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ritesh_flutter_task/Pages/LoginPages/get_started_page.dart';
import 'package:ritesh_flutter_task/Providers/phone_verify_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhoneVerifyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        title: 'Ritesh Flutter',
        home: const GetStartedPage(),
      ),
    );
  }
}
