import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;

  ThemeProvider(String theme) {
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalStorage.saveTheme('dark');
    } else {
      themeMode = ThemeMode.light;
      await LocalStorage.saveTheme('light');
    }
    notifyListeners();
  }
}
