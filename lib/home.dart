import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      'Produk': '/produk',
      'Favorite': '/favorite',
      'Keranjang': '/keranjang',
      'Product Card': '/productcard',
      'Kategori Produk': '/kategori',
      'Jenis Produk': '/jenis',
      'Suplier': '/suplier',
      'Gudang': '/gudang',
      'Kurir': '/kurir',
    };

    final routeIcons = {
      'Produk': Icons.shopping_bag,
      'Kategori Produk': Icons.category,
      'Jenis Produk': Icons.list_alt,
      'Suplier': Icons.local_shipping,
      'Gudang': Icons.warehouse,
      'Kurir': Icons.delivery_dining,
      'Favorite': Icons.favorite,
      'Keranjang': Icons.shopping_cart,
      'Product Card': Icons.card_giftcard
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.teal[700], // Sidebar warna lebih hidup
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text(
                  'Menu Utama',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...routes.entries.map(
                (entry) => Column(
                  children: [
                    ListTile(
                      leading: Icon(routeIcons[entry.key], color: Colors.white),
                      title: Text(
                        entry.key,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      hoverColor: Colors.teal[500],
                      onTap: () {
                        Navigator.pop(context);
                        context.go(entry.value);
                      },
                    ),
                    const Divider(
                      color: Colors.white24,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang di Aplikasi Eanccomerce!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Silakan pilih menu di sidebar untuk melakukan CRUD data produk, kategori, jenis, suplier, gudang, ataupun kurir',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: routes.entries.map(
                (entry) => ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => context.go(entry.value),
                  icon: Icon(routeIcons[entry.key]),
                  label: Text(entry.key),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
