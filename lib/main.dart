import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app_module.dart';
import 'theme/roleTheme.dart';
import '../theme/themeManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ModularApp(module: AppModule(), child: const RoleApp()));
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
    return MaterialApp.router(
      title: 'RoleSp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
      ),
      themeMode: _themeManager.themeMode,
      routerConfig: Modular.routerConfig,
    );
  }
}
