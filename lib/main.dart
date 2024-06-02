import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rolesp/main_cubit.dart';
import 'package:rolesp/main_state.dart';
import 'package:rolesp/services/firebase_messaging_service.dart';
import 'package:rolesp/services/notification_service.dart';

import 'app_module.dart';
import 'theme/roleTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const RoleApp(),
    ),
  );
}


class RoleApp extends StatelessWidget {
  const RoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<MainCubit>();
    final fireBaseMessagingService = Modular.get<FirebaseMessagingService>();
    final notificationService = Modular.get<NotificationService>();

    fireBaseMessagingService.initialize();
    notificationService.checkForNotifications();
    cubit.getTheme();

    return BlocBuilder<MainCubit, MainState>(
        bloc: cubit,
        builder: (context, state) {
          var theme = ThemeMode.dark;

          if (state is LightMode) {
            theme = ThemeMode.light;
          }

          return MaterialApp.router(
            title: 'RoleSp',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme,
            ),
            themeMode: theme,
            routerConfig: Modular.routerConfig,
          );
        });
  }
}
