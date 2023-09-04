import 'dart:async';
import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sheraa_cms/bloc/app_bloc.dart';
import 'package:sheraa_cms/ui/home_screen.dart';
// import 'firebase_options.dart';
import 'main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => GetIt.asNewInstance();

Future<void> main() async {
  runZonedGuarded<void>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // setupLocator();
    configureDependencies();
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            print("close your eyes cms");
            return AppBloc()..add(InitialAppEvent());
          },
        ),
      ],
      child: NavigationRailExampleApp(),
    ));
    // runApp(const NavigationRailExampleApp());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
