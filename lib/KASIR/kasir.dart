
import 'package:adminecomerce/KASIR/beranda.dart';
import 'package:adminecomerce/KASIR/pesanan.dart';
import 'package:adminecomerce/KASIR/produk.dart';
import 'package:adminecomerce/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Kasir extends StatefulWidget {
  const Kasir({super.key});

  @override
  State<Kasir> createState() => _KasirState();
}

final c = Get.put(Controllersr());

class _KasirState extends State<Kasir> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }



  List<Widget> data = [Beranda(), Pesanan(), Produk()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data[_selectedNavbar],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.person,
          color: Colors.orange,
        ),
        title: Text(
          'Kasir Ku',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Produk',
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
