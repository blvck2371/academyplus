import 'package:flutter/material.dart';

class ModelMenuCour extends StatelessWidget {
  ModelMenuCour(
      {super.key, required this.libelleClasse, required this.nombreMatiere});

  final String libelleClasse;
  final String nombreMatiere;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //design debut
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 50,
                    color: Theme.of(context).primaryColorDark,
                    child: SizedBox(
                      width: 6,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Classe',
                        style: TextStyle(fontSize: 22),
                      ),
                      Text('nombre de lecon' + ' ${this.nombreMatiere}'),
                    ],
                  ),
                ],
              ),
            ],
          ),

          //fin designn de bord
          //affichage des text matier et nb de classe

          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Text(
                  '${libelleClasse}',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          )
          //fin

          // affichage du libele de la classe
        ],
      ),
    );
  }
}
