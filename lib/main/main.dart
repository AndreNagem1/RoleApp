import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rolesp/main/main_cubit.dart';
import 'package:rolesp/screens/splash_screen/ui/SplachScreen.dart';

import '../theme/roleTheme.dart';
import '../theme/themeManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RoleSpApp());
}

ThemeManager themeManager = ThemeManager();
ThemeManager mainCubit = ThemeManager(false);

class RoleSpApp extends StatelessWidget {
  const RoleSpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RoleSp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
      ),
      themeMode: themeManager.themeMode,
      home: SplashScreen(mainCubit: mainCubit),
    );
  }
}
