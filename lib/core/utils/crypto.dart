import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:sup_transp_app/core/error/failures.dart';

class CryptoConverter {
  Either<Failure, String> encryptMD5(String cadena) {
    try {
      if (cadena.trim().length > 0) {
        String passwordEncryp =
            md5.convert(utf8.encode(cadena.trim())).toString().toUpperCase();
        return Right(passwordEncryp);
      } else {
        throw FormatException();
      }
    } on FormatException {
      return Left(CryptoConverterFailure());
    }
  }
}

class CryptoConverterFailure extends Failure {}
