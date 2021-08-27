import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String codUsuario;
  final String password;

  Usuario({
    required this.codUsuario,
    required this.password,
  });

  @override
  List<Object> get props => [codUsuario, password];
}
