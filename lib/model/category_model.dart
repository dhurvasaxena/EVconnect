import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/material.dart';

Future<void> saveCategoryItems() async {
  final CollectionReference ref = FirebaseFirestore.instance.collection(
    "myAppCategory",
  );
  for (final Category category in categoriesList) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(category.toMap());
  }
}
 
class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'image': image};
  }
}

final List<Category> categoriesList = [
  Category(title: "AC(fast)", image: "https://ibb.co/Q3dPjPcx"),
  Category(title: "AC(slow)", image: "https://ibb.co/LDRY2xSk"),
  Category(title: "DC", image: "https://ibb.co/CpBD2G3y"),
  Category(title: "AC(other)", image: "https://ibb.co/cctS4QzQ"),
];
