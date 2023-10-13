import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: ColorsRoleSp.perfectPurple,
  onPrimary: ColorsRoleSp.surfaceLight,
  secondary: ColorsRoleSp.secondaryLight,
  onSecondary: ColorsRoleSp.perfectPurple,
  error: ColorsRoleSp.perfectPurple,
  onError: ColorsRoleSp.perfectPurple,
  background: ColorsRoleSp.surfaceLight,
  onBackground: ColorsRoleSp.perfectPurple,
  surface: ColorsRoleSp.surfaceLight,
  onSurface: ColorsRoleSp.onSurfaceLight,
  tertiary: ColorsRoleSp.tertiaryLight,
  onTertiary: ColorsRoleSp.unselectedIconLight,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: ColorsRoleSp.perfectPurple,
  onPrimary: ColorsRoleSp.surfaceLight,
  secondary: ColorsRoleSp.secondaryDark,
  onSecondary: ColorsRoleSp.perfectPurple,
  error: ColorsRoleSp.perfectPurple,
  onError: ColorsRoleSp.perfectPurple,
  background: ColorsRoleSp.surfaceLight,
  onBackground: ColorsRoleSp.perfectPurple,
  surface: ColorsRoleSp.surfaceDark,
  onSurface: ColorsRoleSp.onSurfaceDark,
  tertiary: ColorsRoleSp.tertiaryDark,
  onTertiary: ColorsRoleSp.unselectedIconLight,
);
