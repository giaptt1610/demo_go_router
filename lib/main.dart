import 'package:demo_go_router/blocs/cart/cart_bloc.dart';
import 'package:demo_go_router/routes/app_router.dart';
import 'package:demo_go_router/service_locator.dart';
// import 'package:demo_go_router/routes/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/app/app_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appBloc = AppBloc();
  late AppRouter appRouter;

  MyApp() {
    appRouter = AppRouter(appBloc.stream);
    getIt.registerSingleton<AppRouter>(appRouter);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => appBloc),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp.router(
        routeInformationParser: appRouter.router.routeInformationParser,
        routerDelegate: appRouter.router.routerDelegate,
        title: 'Go Router',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
