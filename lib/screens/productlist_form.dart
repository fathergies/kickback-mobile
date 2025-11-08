import 'package:flutter/material.dart';
import 'package:kickback/widgets/left_drawer.dart';
import 'package:kickback/screens/menu.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      drawer: const LeftDrawer(),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  hintText: "Masukkan nama produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk wajib diisi";
                  }
                  if (value.length < 3) {
                    return "Nama minimal 3 karakter";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Spesifikasi (opsional)",
                  hintText: "Masukkan detail bahan atau ukuran",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 2,
                onChanged: (value) => setState(() => _specification = value),
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Harga Produk (Rp)",
                  hintText: "Masukkan harga (dalam angka)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _price = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga wajib diisi";
                  }
                  final price = int.tryParse(value);
                  if (price == null) {
                    return "Harga harus berupa angka";
                  }
                  if (price < 0) {
                    return "Harga tidak boleh negatif";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Deskripsi Produk",
                  hintText: "Masukkan deskripsi singkat produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
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

              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL Thumbnail",
                  hintText: "https://contoh.com/gambar.png",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => setState(() => _thumbnail = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "URL thumbnail wajib diisi";
                  }
                  final uri = Uri.tryParse(value);
                  if (uri == null || !uri.isAbsolute || !value.startsWith('http')) {
                    return "Masukkan URL yang valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Kategori Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _category,
                items: _categories
                    .map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (newValue) => setState(() => _category = newValue!),
              ),
              const SizedBox(height: 12),

              SwitchListTile(
                title: const Text("Tandai sebagai Produk Unggulan"),
                value: _isFeatured,
                onChanged: (value) => setState(() => _isFeatured = value),
              ),
              const SizedBox(height: 20),

              Center(
                child: SizedBox(
                  width: 160,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text(
                                'Produk berhasil disimpan!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Nama: $_name'),
                                  if (_specification.isNotEmpty)
                                    Text('Spesifikasi: $_specification'),
                                  Text('Harga: Rp$_price'),
                                  Text('Deskripsi: $_description'),
                                  Text('Kategori: $_category'),
                                  Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context); 
                                    Navigator.pop(context); 
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
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
