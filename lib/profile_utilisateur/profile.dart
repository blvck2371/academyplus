import 'package:academyplus/profile_utilisateur/element_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';

class UserProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity, // Largeur qui prend tout l'écran
                height: 200, // Hauteur fixée à 100
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://cursus.edu/storage/thumbnails/9kDITopJRWhvzBgKru2ooYEGEZ969eHuGkaGTbq8.jpeg'),
                    fit: BoxFit.cover, // Ajuste l'image au container
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 275,
                width: double.infinity,
                //decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white, size: 32),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundImage: NetworkImage(
                                            'https://camerounfuture.com/wp-content/uploads/2020/11/Lycee-1-1024x630.jpg'), // Ajoutez votre image ici
                                      ),
                                      Positioned(
                                        left: 125.5,
                                        bottom: 25,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              Get.snackbar("Action",
                                                  "Vous avez appuyé sur modification photo de profil",
                                                  snackPosition:
                                                      SnackPosition.TOP);
                                            },
                                            icon: Icon(Icons.camera_enhance,
                                                color: Colors.white, size: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Lindou N.',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Icon(
                                              Icons.verified,
                                              color: Colors.blue,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                          // Container(
                          //     margin: EdgeInsets.only(top: 100),
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //           margin: const EdgeInsets.only(left: 0),
                          //           child: Text(
                          //             'Lindou N.',
                          //             style: TextStyle(fontSize: 20),
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 5),
                          //           child: Icon(
                          //             Icons.verified,
                          //             color: Colors.blue,
                          //           ),
                          //         )
                          //       ],
                          //     )),
                          Container(
                            margin: EdgeInsets.only(right: 10, top: 50),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.snackbar("Action",
                                    "Vous avez appuyé sur modification photo de profil",
                                    snackPosition: SnackPosition.TOP);
                              },
                              icon: Icon(Icons.camera_enhance,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      ElementProfil(
                          libelle: 'Nom',
                          nom: 'Lindou Ngapout',
                          icone: Icons.person),
                      ElementProfil(
                          libelle: 'Prenom',
                          nom: 'Abdel Raoufou',
                          icone: Icons.person),
                      ElementProfil(
                          libelle: 'Age', nom: '27', icone: Icons.cake),
                      ElementProfil(
                          libelle: 'téléphone',
                          nom: '+237691322304',
                          icone: Icons.phone),
                      ElementProfil(
                          libelle: 'Email',
                          nom: 'lindoungapoutabdel@gmail.com',
                          icone: Icons.email),
                      ElementProfil(
                          libelle: 'Etablissement',
                          nom: 'Lycee de Ngaoundéré Mardock',
                          icone: Icons.school),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
