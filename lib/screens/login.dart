import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kickback/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kickback/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            color: Colors.white,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.green.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to continue',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // USERNAME
                  TextField(
                    controller: _usernameController,
                    style: GoogleFonts.inter(),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: GoogleFonts.inter(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: Colors.green.shade700),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // PASSWORD
                  TextField(
                    controller: _passwordController,
                    style: GoogleFonts.inter(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.inter(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: Colors.green.shade700),
                      ),
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 28),

                  // LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        final response = await request.login(
                          "http://localhost:8000/auth/login/",
                          {
                            'username': username,
                            'password': password,
                          },
                        );

                        if (request.loggedIn) {
                          String message = response['message'];
                          String uname = response['username'];

                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green.shade700,
                                  content:
                                      Text("$message Welcome, $uname.",
                                        style: GoogleFonts.inter(color: Colors.white),
                                      ),
                                ),
                              );
                          }
                        } else {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                title: Text(
                                  'Login Failed',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  response['message'],
                                  style: GoogleFonts.inter(),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK',
                                        style: GoogleFonts.inter(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: GoogleFonts.inter(
                        color: Colors.green.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
