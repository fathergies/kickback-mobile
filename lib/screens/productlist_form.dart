import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kickback/widgets/left_drawer.dart';
import 'package:kickback/screens/menu.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _specification = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "JERSEY";
  bool _isFeatured = false;

  final List<String> _categories = [
    'JERSEY',
    'SHORTS',
    'SHOES',
    'GEAR',
    'MERCH',
    'OTHERS',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      drawer: const LeftDrawer(),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              // NAME
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk wajib diisi";
                  }
                  if (value.length < 3) return "Minimal 3 karakter";
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // SPECIFICATION
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Spesifikasi (opsional)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) => setState(() => _specification = value),
                maxLines: 2,
              ),

              const SizedBox(height: 16),

              // PRICE
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Harga Produk",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _price = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Harga wajib diisi";

                  final price = int.tryParse(value);
                  if (price == null) return "Harga harus angka";
                  if (price < 0) return "Harga tidak boleh negatif";

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // DESCRIPTION
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                minLines: 3,
                maxLines: 4,
                onChanged: (value) => setState(() => _description = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi wajib diisi";
                  }
                  if (value.length < 10) {
                    return "Deskripsi minimal 10 karakter";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // THUMBNAIL
              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL Thumbnail (opsional)",
                  hintText: "https://contoh.com/gambar.png",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) => setState(() => _thumbnail = value),
                validator: (value) {
                  // OPTIONAL — boleh kosong
                  if (value == null || value.isEmpty) return null;

                  final uri = Uri.tryParse(value);
                  if (uri == null || !uri.isAbsolute) {
                    return "URL tidak valid";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CATEGORY DROPDOWN
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                items: _categories
                    .map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),

              const SizedBox(height: 12),

              // FEATURED
              SwitchListTile(
                title: const Text("Tandai sebagai Featured"),
                value: _isFeatured,
                onChanged: (value) => setState(() => _isFeatured = value),
              ),

              const SizedBox(height: 20),

              // SUBMIT BUTTON
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        "http://localhost:8000/create-product-flutter/",
                        jsonEncode({
                          "name": _name,
                          "specification": _specification,
                          "price": _price.toString(),
                          "description": _description,
                          "thumbnail": _thumbnail,
                          "category": _category,
                          "is_featured": _isFeatured,
                        }),
                      );

                      if (!context.mounted) return;

                      if (response['id'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Product successfully saved!")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Failed to save product. Please try again.")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
