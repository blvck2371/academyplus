import 'package:academyplus/Databasefirestore/ConnectDbFire.dart';
import 'package:academyplus/Theme/themeColors.dart';
import 'package:academyplus/Theme/themedesobjets.dart';
import 'package:academyplus/home/home.dart';
import 'package:academyplus/login/loginforme.dart';
import 'package:academyplus/profile_utilisateur/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Get.put(ThemeController());
  runApp(MyApp());
}

class CounterController extends GetxController {
  var cont = 2.obs;
  void incrementtion() {
    cont++;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());
  final User = FirebaseAuth.instance.userChanges();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          /*

              route pour naviger dans le profil utilisateur.

              */

          initialRoute: FirebaseAuth.instance.currentUser?.email != null
              ? '/'
              : '/loginform',

          getPages: [
            GetPage(
              name: '/',
              page: () => MyHomePage(title: 'AcademyPlus'),
            ),
            GetPage(name: '/profil', page: () => UserProfil()),
            GetPage(name: '/loginform', page: () => AuthPage())
          ],

          //fin route profil utilisateur

          title: 'AcademyPlus',
          debugShowCheckedModeBanner: false,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,

          theme: themeController.isDarkMode.value ? darkTheme : lightTheme,
          //theme: ThemeData.light(), // 🎨 Thème clair
          darkTheme: darkTheme, // 🌙 Thème sombre
          //home: const MyHomePage(title: 'AcademyPlus'),
        ));
  }
}
