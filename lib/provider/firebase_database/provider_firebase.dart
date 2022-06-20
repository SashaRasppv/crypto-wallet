import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProviderFirebase extends ChangeNotifier {
  Future<void> addCoin(String coinName, double amount) async {
    
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection('Coins')
        .doc(coinName)
        .get();
    
    try {
      if (!document.exists) {
        FirebaseFirestore.instance
            .collection('Coins')
            .doc(coinName)
            .set({'Amount': amount});        
      } else {     
        FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(
              FirebaseFirestore.instance.collection('Coins').doc(coinName));
          double newAmout = snapshot.get('Amount') + amount;
          transaction.update(
              FirebaseFirestore.instance.collection('Coins').doc(coinName),
              {'Amount': newAmout});
        });
      }     
    } catch (e) {
      print(e);
    }
    
  }
}
