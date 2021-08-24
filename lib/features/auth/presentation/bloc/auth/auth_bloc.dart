import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:sup_transp_app/core/utils/crypto.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';
import 'package:sup_transp_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sup_transp_app/features/auth/domain/usecases/auth_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;
  //final AuthRepository authRepository;
  final CryptoConverter cryptoConverter;
  AuthBloc({required this.authUseCase, required this.cryptoConverter})
      : super(AuthInitial());

  /* @override
  AuthState get initialState => AuthInitial(); */

  String? codUsuario;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield LoadingState();
      final encryptEither = cryptoConverter.encryptMD5(event.password);

      yield* encryptEither.fold((failure) async* {
        yield ErrorState(message: INVALID_PASSWORD_MESSAGE);
      }, (string) async* {
        //yield LoadingState();
        this.codUsuario = event.codUsuario;
        final failureOrtoken = await authUseCase.login(
            Params(codUsuario: event.codUsuario, password: event.password));
        yield* _eitherLoadedOrErrorState(failureOrtoken);
      });
    }

    if (event is LogoutEvent) {
      this.codUsuario = "ninguno";
      yield LoggedOutState(usuario: "ninguno");
    }
  }

  Stream<AuthState> _eitherLoadedOrErrorState(
    Either<Failure, String> failureOrUsuario,
  ) async* {
    yield failureOrUsuario.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (token) => LoggedInState(token: token),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_PASSWORD_MESSAGE = 'Invalid Password.';
