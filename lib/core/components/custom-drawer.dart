import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)], // Biru gradasi
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent, // transparan, biar ikut gradasi
              ),
              currentAccountPicture: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00C6FF),
                    Color(0xFF0072FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    user?.photoURL ??
                        'https://cdn-icons-png.flaticon.com/512/616/616408.png',
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
            ),
              accountName: Text(
                user?.displayName ?? 'Welcome',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                user?.email ?? 'guest@example.com',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    text: 'Produk Card',
                    onTap: () => context.go('/produkCard'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.shopping_bag,
                    text: 'Produk',
                    onTap: () => context.go('/produk'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.category,
                    text: 'Kategori Produk',
                    onTap: () => context.go('/kategori'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.label,
                    text: 'Jenis Produk',
                    onTap: () => context.go('/jenis'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.warehouse,
                    text: 'Gudang',
                    onTap: () => context.go('/gudang'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.local_shipping,
                    text: 'Kurir',
                    onTap: () => context.go('/kurir'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.store,
                    text: 'Suplier',
                    onTap: () => context.go('/suplier'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.shopping_cart,
                    text: 'Keranjang',
                    onTap: () => context.go('/keranjang'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.favorite,
                    text: 'Favorite',
                    onTap: () => context.go('/favorite'),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white30,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Logout'),
                        content: const Text('Yakin ingin logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
                              context.go('/');
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Card(
        color: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          onTap: onTap,
          hoverColor: Colors.blueAccent.withOpacity(0.3),
        ),
      ),
    );
  }
}
