// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// Future<bool> addCoinToFirebase(String coinName, double amount) async {
//   try {
//     DocumentReference documentReference =
//         FirebaseFirestore.instance.collection('Coins').doc(coinName);
//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(documentReference);
//       if (!snapshot.exists) {
//         documentReference.set({'Amount': amount});
//         return true;
//       }
//       double newAmout = snapshot.get('Amount') + amount;
//       transaction.update(documentReference, {'Amount': newAmout});
//       return true;
//     });
//     return true;
//   } catch (e) {
//     print(e);
//     return false;
//   }
// }
