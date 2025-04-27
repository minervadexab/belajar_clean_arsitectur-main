import 'package:belajar_clean_arsitectur/features/kurir/data/models/kurir_model.dart';
import 'package:belajar_clean_arsitectur/features/kurir/domain/entities/kurir.dart';
import 'package:dartz/dartz.dart';

abstract class KurirRepositorie {
  Future<Either<Exception, List<Kurir>>> getAllKurir();
  Future<Either<Exception, Kurir>> getKurirById({required String id});
  Future<Either<Exception, void>> addKurir({required KurirModel kurir});
  Future<Either<Exception, void>> editKurir({required KurirModel kurir});
  Future<Either<Exception, void>> deleteKurir({required String id});
}