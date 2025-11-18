import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kickback/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kickback/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'KickBack',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF3F4F6),
          textTheme: GoogleFonts.interTextTheme(),

          colorScheme: const ColorScheme.light(
            primary: Color(0xFF22C55E),      // Green-500
            primaryContainer: Color(0xFFBBF7D0), // Green-200
            secondary: Color(0xFF15803D),    // Green-700
            surface: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Color(0xFF1F2937),
          ),

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF1F2937),
            elevation: 0,
            centerTitle: true,
          ),

          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
