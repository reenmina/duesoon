import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(DueSoonApp());
}

class DueSoonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DueSoon',

      theme: ThemeData(
        primaryColor: Color(0xFF3EB489), // mint green
        scaffoldBackgroundColor: Color(0xFFF2FFFB),

        colorScheme: ColorScheme.light(
          primary: Color(0xFF3EB489),
          secondary: Color(0xFF7BE0C3),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF3EB489),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3EB489),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      home: LoginScreen(),
    );
  }
}
