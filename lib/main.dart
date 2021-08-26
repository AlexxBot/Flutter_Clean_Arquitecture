import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:sup_transp_app/features/auth/domain/repositories/auth_repository.dart';
//import 'package:sup_transp_app/features/auth/domain/usecases/auth_use_case.dart';
//import 'package:sup_transp_app/features/auth/domain/usecases/auth_use_case.dart';

import 'app.dart';
//import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/mantenimientos/presentation/bloc/bloc/product_bloc.dart';
import 'injection_container.dart' as di;
import '../../../../injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(authUseCase: AuthUseCase()),
        ),
      ],
      child: SusTransApp(),
    ); */
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
      ],
      /* create: (_) => sl<AuthBloc>(), */
      child: DemoApp(),
    );
  }
}
