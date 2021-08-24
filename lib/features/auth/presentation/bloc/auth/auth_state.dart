part of 'auth_bloc.dart';

enum Proceso { login, logout }

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class LoggedInState extends AuthState {
  final String token;
  LoggedInState({required this.token});
}

class LoggedOutState extends AuthState {
  final String usuario;

  LoggedOutState({required this.usuario});
}

class ErrorState extends AuthState {
  final String message;
  ErrorState({required this.message});
}
