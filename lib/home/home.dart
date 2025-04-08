import 'package:academyplus/Databasefirestore/ConnectDbFire.dart';
import 'package:academyplus/Menu/menuCours.dart';
import 'package:academyplus/main.dart';
import 'package:academyplus/sidebar/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:academyplus/home/carourssel.dart';

import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterController compteur = Get.put(CounterController());

  String getGreeting() {
    int hour = DateTime.now().hour;
    return (hour >= 0 && hour < 12) ? "Bonjour" : "Bonsoir";
  }

  List<Map<String, dynamic>> _classes = [];
  // Fonction pour récupérer les données depuis Firestore
  Future<void> _fetchClasses() async {
    try {
      var collection = FirebaseFirestore.instance.collection('academyClasses');
      var snapshot = await collection.get();
      print("_classes[index]");

      if (snapshot.docs.isNotEmpty) {
        setState(() {});
        (() {
          _classes = snapshot.docs.map((doc) => doc.data()).toList();
        });
      } else {
        print('La collection est vide.');
      }
    } catch (e) {
      print('Erreur lors de la connexion à Firestore : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.25; // 25% de l'écran pour le carousel

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          elevation: 1,
          scrolledUnderElevation: 5,
          shadowColor: Colors.black,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Glyphicon.search)),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 7),
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications),
                      ),
                      Positioned(
                        top: 2, // Positionner le badge en haut de l'icône
                        right: 5, // Le positionner à droite de l'icône
                        child: Container(
                          height:
                              22, // Plus petit pour une notification réaliste
                          width:
                              22, // Plus petit pour une notification réaliste
                          decoration: BoxDecoration(
                            color: Colors.red, // Couleur de fond
                            shape: BoxShape.circle, // Forme circulaire
                          ),
                          alignment: Alignment
                              .center, // Centrer le texte à l'intérieur du cercle
                          child: Text(
                            textAlign: TextAlign.center,
                            '15', // Le chiffre de la notification
                            style: TextStyle(
                              color:
                                  Colors.white, // Couleur du texte (ici, blanc)
                              fontSize: 12, // Taille du texte plus petite
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Glyphicon.justify_left, size: 34),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
            child: Text(
              widget.title,
              style: TextStyle(letterSpacing: 4),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texte de bienvenue
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    "${getGreeting()}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    " ${UserData!.displayName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: imageHeight,
                child: ImageCarouselWidget(),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // TabBar sous le carrousel
            TabBar(
              indicatorColor: Theme.of(context).primaryColorDark,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColorDark,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Text(
                    "Cours".capitalizeFirst!,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2),
                  ),
                ),
                Tab(
                  child: Text(
                    "Épreuves".capitalizeFirst!,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2),
                  ),
                ),
                Tab(
                  child: Text(
                    "News".capitalizeFirst!,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2),
                  ),
                ),
              ],
            ),

            // Contenu du TabBarView qui prend le reste de l'espace
            Expanded(
              child: TabBarView(
                children: [
                  // Cours
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('academyClasses')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child:
                                    CircularProgressIndicator()); // Affiche un indicateur de chargement
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Erreur : ${snapshot.error}'));
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: Text('Aucune donnée trouvée.'));
                          }

                          var classes = snapshot.data!.docs;

                          return ListView.builder(
                            shrinkWrap:
                                true, // Permet au ListView de s'adapter à son contenu
                            physics:
                                NeverScrollableScrollPhysics(), // Désactive le défilement du ListView
                            itemCount: classes
                                .length, // Utilise la longueur de la liste des documents
                            itemBuilder: (context, index) {
                              var classe =
                                  classes[index].data() as Map<String, dynamic>;
                              var libelleClasse = classe['Classe'] ??
                                  'Non spécifié'; // Prend la classe, par défaut 'Non spécifié'

                              return Container(
                                margin: EdgeInsets.only(top: 15),
                                child: ModelMenuCour(
                                  libelleClasse: libelleClasse,
                                  nombreMatiere: (index + 1)
                                      .toString(), // Affiche le numéro de l'index ou d'autres informations
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Épreuves
                  Center(child: Text("📝 Contenu des Épreuves")),

                  // News
                  Center(child: Text("📰 Contenu des News")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
