import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProviderFirebase extends ChangeNotifier {
  Future<void> addCoin(String coinName, double amount) async {
    DocumentSnapshot<Map<String, dynamic>> documnet = await FirebaseFirestore
        .instance
        .collection('Coins')
        .doc(coinName)
        .get();
    try {
      if (!documnet.exists) {
        print('is empty');
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
          return true;
        });
        print('is not empty');
      }
    } catch (e) {
      print(e);
    }
  }
}
//   Future<void> updateCoin(String coinName, String amount) async {
//     try {
//       FirebaseFirestore.instance.collection('Coins').doc(coinName).get();
//           FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore.instance.collection('Coins').doc(coinName));
//       if (!snapshot.exists) {
//         FirebaseFirestore.instance.collection('Coins').doc(coinName).set({'Amount': amount});
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }