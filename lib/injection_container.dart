//import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sup_transp_app/core/network/headers.dart';
import 'package:sup_transp_app/core/utils/crypto.dart';
import 'package:sup_transp_app/features/auth/domain/usecases/auth_use_case.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

import 'features/auth/data/datasources/auth_remote_data.dart';
import 'features/auth/data/repositories/auth_repository_imple.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/product/data/datasources/product_remote_data.dart';
import 'features/product/data/repository/product_repository_imple.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/domain/usecases/product_use_case.dart';
import 'features/product/presentation/bloc/bloc/product_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  //await DotEnv.(fileName: ".env");
  await dotenv.load(fileName: ".env");

  sl.registerFactory(
    () => AuthBloc(
        authUseCase: sl(),
        cryptoConverter:
            sl() // se crea una nueva instancia cada vez que se llama
        /* inputConverter: sl(),
      random: sl(), */
        ),
  );

  sl.registerFactory(
    () => ProductBloc(
      productUseCase: sl(),
    ),
  );
  //para los headers que va a a ser configurables prinnipalmente por los tokens
  sl.registerLazySingleton(() => Headers());

  // Use cases
  sl.registerLazySingleton(
      () => AuthUseCase(sl())); //se inicializa en la primera llamada
  //sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  sl.registerLazySingleton(
      () => ProductUseCase(sl())); //se inicializa en la primera llamada

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      //localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      //localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteData>(
    () => AuthRemoteDataImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductRemoteData>(
    () => ProductRemoteDataImpl(client: sl()),
  );

  /* sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  ); */

  //! Core
  sl.registerLazySingleton(() => CryptoConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
      /* sl() */ /* "https://api-rest-auth-node.herokuapp.com" */ dotenv
          .env['URL']!));

  //! External
  //final sharedPreferences = await SharedPreferences.getInstance();
  //sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  //sl.registerLazySingleton(() => DataConnectionChecker());
}
