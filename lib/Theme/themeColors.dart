import 'package:academyplus/Theme/themedesobjets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs; // Variable réactive pour stocker l'état du thème

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    // isDarkMode.value = !isDarkMode.value;
    // Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
    // box.write("darkMode", isDarkMode.value); // Sauvegarder l'état
  }
}
