import 'package:equatable/equatable.dart';
import 'package:flutter/src/material/dropdown.dart';

class Jenis extends Equatable {
  final String id;
  final String namaJenis;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Jenis(
      {required this.id,
      required this.namaJenis,
      required this.deskripsi,
      this.createdAt,
      this.updatedAt});
  @override
  List<Object?> get props => [id, namaJenis, deskripsi, createdAt, updatedAt];

  map(DropdownMenuItem<String> Function(dynamic jenis) param0) {}
}
