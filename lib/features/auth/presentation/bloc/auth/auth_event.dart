part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String codUsuario;
  final String password;

  LoginEvent({required this.codUsuario, required this.password});
}

class LogoutEvent extends AuthEvent {
  LogoutEvent();
}
