import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rolesp/screens/splash_screen/ui/SplashScreen.dart';

import 'theme/roleTheme.dart';
import '../theme/themeManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RoleApp());
}

ThemeManager _themeManager = ThemeManager();

class RoleApp extends StatefulWidget {
  const RoleApp({super.key});

  @override
  State<RoleApp> createState() => _RoleAppState();
}

class _RoleAppState extends State<RoleApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

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
      themeMode: _themeManager.themeMode,
      home: SplashScreen(themeManager: _themeManager),
    );
  }
}
