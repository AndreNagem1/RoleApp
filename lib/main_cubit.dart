import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(DarkMode());

  var currentTheme = ThemeMode.dark;
  var jumpLogin = false;

  void toggleTheme(bool isDark) {
    jumpLogin = true ;

    if (isDark) {
      currentTheme = ThemeMode.dark;
      emit(DarkMode());
    } else {
      currentTheme = ThemeMode.light;
      emit(LightMode());
    }
  }
}
