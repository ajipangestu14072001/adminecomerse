import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Controllersr extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  var firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxInt jumlah_produk = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> produk() {
    var data = firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('produk');
    return data.snapshots();
  }


  



  Stream<DocumentSnapshot<Map<String, dynamic>>> get_order(String id) {
    var data = firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('order')
        .doc(id);
    return data.snapshots();
  }

//
//
//
//kasir kontroller
//
//
//
  final imagePicker = ImagePicker();
  XFile? pickedImage = null;
  RxString image = "".obs;

  void selectedImageGalery() async {
    try {
      final cekFoto = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 60);
      if (cekFoto != null) {
        pickedImage = cekFoto;
      }
      update();
    } catch (e) {
      pickedImage = null;
      update();
    }
  }

  void resetImage() {
    pickedImage = null;
    update();
  }

  Future<String?> uploadImage(String uid) async {
    Reference storageRef = storage.ref("$uid.png");
    File file = File(pickedImage!.path);
    try {
      await storageRef.putFile(file);
      final photoUrl = await storageRef.getDownloadURL();
      await RxStatus.loading();
      resetImage();
      image(photoUrl);
      return photoUrl;
    } catch (e) {
      Get.snackbar('Gagal', 'periksa koneksi Internet anda',
          backgroundColor: Colors.grey,
          borderRadius: 20,
          colorText: Colors.red);
      return null;
    }
  }

  void tambah_produk(
      String deskripsi, String harga, String image, String nama) async {
    firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('produk')
        .add({
      "deskripsi_produk": deskripsi,
      "harga": harga,
      "image": image,
      "nama": nama,
      "time": DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()
    });
    Get.back();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get_order_kasir() {
    var data = firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('order')
        .orderBy("jam", descending: true);
    return data.snapshots();
  }

  void update_pesanan(String id) {
    firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('order')
        .doc(id)
        .update({"status": 'SUDAH DI BAYAR', "selesai": id.toString()});
  }

  void hapus_pesanan(String id) {
    firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('order')
        .doc(id)
        .delete();
  }

  void hapus_produk(String id, String url) async {
    firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('produk')
        .doc(id)
        .delete();
    await FirebaseStorage.instance.refFromURL(url).delete();
    firestore
        .collection("Toko")
        .doc('ug72tF0uJnIyyLI2a6xX')
        .collection('keranjang')
        .doc(id)
        .delete();
  }
}
