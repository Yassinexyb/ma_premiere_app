import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'login_page.dart';

late SharedPreferences prefs;

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 prefs = await SharedPreferences.getInstance();
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
   final connecte = prefs.getBool('connecte') ?? false;

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       colorSchemeSeed: Colors.lightGreen,
       appBarTheme: const AppBarTheme(
         backgroundColor: Colors.lightGreen,
       ),
     ),
     home: connecte ? const HomePage() : const LoginPage(),
   );
 }
}