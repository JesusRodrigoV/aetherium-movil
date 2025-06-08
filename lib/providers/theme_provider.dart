import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system) {
    _cargarTema();
  }

  void _cargarTema() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode');
    if (themeIndex != null &&
        themeIndex >= 0 &&
        themeIndex < ThemeMode.values.length) {
      state = ThemeMode.values[themeIndex];
    }
  }

  void setThemeMode(ThemeMode newMode) async {
    if (state == newMode) return;
    state = newMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', newMode.index);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>((ref) => ThemeProvider());

final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  if (themeMode == ThemeMode.system) {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
  return themeMode == ThemeMode.dark;
});
