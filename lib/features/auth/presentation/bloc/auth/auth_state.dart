part of 'auth_bloc.dart';

enum Proceso { login, logout }

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class LoggedState extends AuthState {
  final String token;
  LoggedState({required  this.token });
}

class ErrorState extends AuthState {
  final String message;
  ErrorState({required this.message});
}
