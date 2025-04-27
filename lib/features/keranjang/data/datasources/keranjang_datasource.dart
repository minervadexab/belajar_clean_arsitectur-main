import 'package:belajar_clean_arsitectur/features/keranjang/data/models/keranjang_model.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/domain/entities/keranjang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class KeranjangRemoteDataSource {
  Future<List<Keranjang>> getAllKeranjang();
  Future<Keranjang> getKeranjangById({required String id});
  // void tidak ada pengembalian
  Future<void> addKeranjang({required KeranjangModel keranjang});
  Future<void> editKeranjang({required KeranjangModel keranjang});
  Future<void> deleteKeranjang({required String id});
  
}

class KeranjangRemoteDataSourceImplementation
    implements KeranjangRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  KeranjangRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addKeranjang({required KeranjangModel keranjang}) async {
    await firebaseFirestore
        .collection('Keranjangs')
        .add(keranjang.toFireStore());
  }

  @override
  Future<void> deleteKeranjang({required String id}) async {
    await firebaseFirestore.collection('Keranjangs').doc(id).delete();
  }

  @override
  Future<void> editKeranjang({required KeranjangModel keranjang}) async {
    await firebaseFirestore
        .collection('Keranjangs')
        .doc(keranjang.id)
        .update(keranjang.toFireStore());
  }

  @override
  Future<List<Keranjang>> getAllKeranjang() async {
    final data = await firebaseFirestore.collection('Keranjangs').get();
    return data.docs
        .map(
          (e) => KeranjangModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Keranjang> getKeranjangById({required String id}) async {
    final data = await firebaseFirestore.collection('Keranjangs').doc(id).get();
    return KeranjangModel.fromFirestore(data);
  }
}
