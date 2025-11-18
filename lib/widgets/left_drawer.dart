import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kickback/screens/menu.dart';
import 'package:kickback/screens/productlist_form.dart';
import 'package:kickback/screens/product_entry_list.dart';
import 'package:kickback/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KickBack',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Football Gear Marketplace',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          _buildItem(
            context,
            icon: Icons.home_outlined,
            text: "Home",
            page: const MyHomePage(),
          ),

          _buildItem(
            context,
            icon: Icons.storefront_outlined,
            text: "All Products",
            page: const ProductEntryListPage(mode: "all"),
          ),

          _buildItem(
            context,
            icon: Icons.person_outline,
            text: "My Products",
            page: const ProductEntryListPage(mode: "my"),
          ),

          _buildItem(
            context,
            icon: Icons.add_circle_outline,
            text: "Add Product",
            page: const ProductFormPage(),
          ),

          const Divider(height: 24),

          // LOGOUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: GoogleFonts.inter(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () async {
              final request = context.read<CookieRequest>();

              final response = await request.logout(
                "http://localhost:8000/auth/logout/",
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(response['message'] ?? 'Logged out'),
                  ),
                );

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.grey[800],
          letterSpacing: -0.2,
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
