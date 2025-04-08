// import 'dart:ui';

// import 'package:flutter/material.dart';

// class ElementProfil extends StatelessWidget {
//   ElementProfil(
//       {super.key,
//       require,
//       required this.libelle,
//       required this.nom,
//       required this.icone});
//   String nom;
//   String libelle;
//   Icon icone;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Icon(this.icone),
//                   Text('${this.libelle}'),
//                 ],
//               ),
//               Text(
//                 '${this.nom}',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           Container(
//             child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ElementProfil extends StatelessWidget {
  const ElementProfil({
    super.key,
    required this.libelle,
    required this.nom,
    required this.icone,
  });

  final String nom;
  final String libelle;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icone,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.5)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            libelle,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            nom,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColorDark),
          ),
        ],
      ),
    );
  }
}
