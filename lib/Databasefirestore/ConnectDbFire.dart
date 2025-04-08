import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<bool> checkDatabaseExists() async {
  try {
    // Référence à la collection 'academyClasses'
    var collection = FirebaseFirestore.instance.collection('academyClasses');
    print('fffffffffffffffffffffffff');

    // Récupérer tous les documents de la collection
    var snapshot = await collection.get();

    // Vérifier si la collection a des documents
    if (snapshot.docs.isNotEmpty) {
      // Afficher chaque document dans la console
      for (var doc in snapshot.docs) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      }
      return true; // La collection existe et contient des documents
    } else {
      print('La collection est vide.');
      return false; // La collection existe mais est vide
    }
  } catch (e) {
    print('Erreur lors de la connexion à Firestore : $e');
    return false; // Erreur de connexion
  }
}

// recuperation des classe dans la bd
//pour se doconnecter
void signOut() {
  FirebaseAuth.instance.signOut();
}

//recuperer les donnee de l'utilisateur actuel
final UserData = FirebaseAuth.instance!.currentUser;
