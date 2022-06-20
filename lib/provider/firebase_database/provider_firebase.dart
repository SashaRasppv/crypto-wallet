import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProviderFirebase extends ChangeNotifier {
  Future<void> addCoin(String coinName, double amount) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Coins')
        .doc(coinName)
        .collection('Amount');
    QuerySnapshot snapshot = await collectionReference.get();
    try {
      if (snapshot.docs.isEmpty) {
        FirebaseFirestore.instance
            .collection('Coins')
            .doc(coinName)
            .set({'Amount': amount});
      } else {
        print('is not empty');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCoin(String coinName, String amount) async {
    try {
      FirebaseFirestore.instance
          .collection('Coins')
          .doc(coinName)
          .update({'Amount': amount});
    } catch (e) {
      print(e);
    }
  }
}
