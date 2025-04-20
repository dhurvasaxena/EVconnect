import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> savePlacesToFirebase() async {
  final CollectionReference ref = FirebaseFirestore.instance.collection(
    "myAppCollection",
  );
  for (final Place place in listOfPlace) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(place.toMap());
  }
}

class Place {
  final String title;
  bool isActive;
  final String image;
  final double rating;
  final String time;
  final int price;
  final String address;
  final String vendor;
  final String vendorProfile;
  final int review;
  final String chargerType;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;

  Place({
    required this.title,
    required this.isActive,
    required this.image,
    required this.rating,
    required this.time,
    required this.address,
    required this.vendor,
    required this.vendorProfile,
    required this.review,
    required this.chargerType,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isActive': isActive,
      'image': image,
      'rating': rating,
      'time': time,
      'address': address,
      'vendor': vendor,
      'vendorProfile': vendorProfile,
      'review': review,
      'chargerType': chargerType,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrls': imageUrls,
    };
  }
}

final List<Place> listOfPlace = [
  Place{
    isActive: true,
    title: "The Forest SPA",
    image: 
  }
]
