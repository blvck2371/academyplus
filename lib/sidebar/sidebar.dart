import 'dart:ffi';

import 'package:academyplus/Databasefirestore/ConnectDbFire.dart';
import 'package:academyplus/Theme/themeColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // HEADER DU MENU (AVATAR, NOM, NUMERO)
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              image: DecorationImage(
                image: NetworkImage(
                  'https://camerounfuture.com/wp-content/uploads/2020/11/Lycee-1-1024x630.jpg',
                ),
                fit: BoxFit
                    .cover, // Ajuste l'image pour couvrir tout le conteneur
              ),
            ),
            accountName: Text(
              "John Doe",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            accountEmail: Text(
              "+123 456 789",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://cursus.edu/storage/thumbnails/9kDITopJRWhvzBgKru2ooYEGEZ969eHuGkaGTbq8.jpeg',
              ), // Remplacez par votre image
            ),
          ),

          // LISTE DES MENUS
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(Icons.home, "Accueil".capitalize.toString(), 1),
                _buildMenuItem(Icons.person, "profil".capitalize.toString(), 2),
                _buildMenuItem(
                  Icons.group,
                  "Groupes".capitalizeFirst.toString(),
                  3,
                ),
                _buildMenuItem(
                  Icons.local_gas_station,
                  "Recharges".capitalizeFirst.toString(),
                  4,
                ),
                _buildMenuItem(Icons.notifications, "Notifications", 5),
                _buildMenuItem(Icons.logout, "Deconnexion", 6),

                Divider(), // Séparation
                // SWITCH POUR CHANGER LE THÈME
                ListTile(
                  leading: Icon(Icons.brightness_6),
                  title: Text("Mode Sombre"),
                  trailing: Obx(
                    () => Switch(
                      activeTrackColor: Theme.of(
                        context,
                      ).primaryColorDark.withOpacity(0.5),
                      value: themeController.isDarkMode.value,
                      onChanged: (value) => themeController.toggleTheme(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int numero) {
    final routes = {
      1: '/',
      2: '/profil',
      3: '/groupes',
      4: '/notifications',
      5: '/deconnexion',
      6: '/loginform',
    };

    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColorDark),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        if (routes.containsKey(numero)) {
          if (numero == 1) {
            Scaffold.of(context).closeDrawer();
          } else if (numero == 6) {
            signOut();
            Get.offAllNamed(routes[numero]!);
          } else {
            Get.toNamed(routes[numero]!);
          }
        } else {
          print("Numéro invalide : $numero");
        }

        // Exemple : Afficher une notification
        // Get.snackbar("Action", "Vous avez appuyé sur $title",
        //   snackPosition: SnackPosition.TOP);
      },
    );
  }
}
