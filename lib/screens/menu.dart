import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kickback/widgets/left_drawer.dart';
import 'package:kickback/screens/productlist_form.dart';
import 'package:kickback/screens/product_entry_list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String nama = "Angelique Natasya Braveina Chelsey Siagian";
  final String npm = "2406496006";
  final String kelas = "F";

  @override
  Widget build(BuildContext context) {
    final List<_HomeButton> items = [
      _HomeButton(
        label: "View Products",
        icon: Icons.store,
        color: const Color(0xFF22C55E), // Green-500
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductEntryListPage(mode: "all"),
          ),
        ),
      ),
      _HomeButton(
        label: "My Products",
        icon: Icons.person,
        color: const Color(0xFF15803D), // Green-700
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductEntryListPage(mode: "my"),
          ),
        ),
      ),
      _HomeButton(
        label: "Add Product",
        icon: Icons.add_box,
        color: const Color(0xFF0D9488), // Teal-600
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductFormPage(),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "KickBack",
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF22C55E),
          ),
        ),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Nama', content: nama),
                InfoCard(title: 'Kelas', content: kelas),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              'Selamat datang di KickBack!',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 20),


            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(18),
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                crossAxisCount: 3,
                children: items
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: item.color.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: item.onTap,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.icon, size: 38, color: Colors.white),
                              const SizedBox(height: 10),
                              Text(
                                item.label,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeButton {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _HomeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.8,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
