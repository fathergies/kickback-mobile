import 'package:flutter/material.dart';
import 'package:kickback/models/product_entry.dart';
import 'package:kickback/widgets/left_drawer.dart';
import 'package:kickback/screens/product_detail.dart';
import 'package:kickback/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final String mode; // "all" atau "my"

  const ProductEntryListPage({
    super.key,
    required this.mode,
  });

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    String url = "http://localhost:8000/json/";

    // Mode "my" → Django sudah support filter=user via GET parameter
    if (widget.mode == "my") {
      url = "http://localhost:8000/json/?filter=my";
    }

    final response = await request.get(url);

    List<ProductEntry> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }

    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == "my"
              ? "My Products"
              : "All Products",
        ),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                "No products found.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
