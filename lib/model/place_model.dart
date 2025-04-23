import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
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
    required this.price,
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
      'price': price,
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
  Place(
    isActive: true,
    title: "The Forest SPA Charging Station",
    image: "https://ibb.co/r24BWF35",
    rating: 4.5,
    time: "11AM-6PM",
    price: 17,
    address: "Sector 93, Noida",
    vendor: "Jignesh",
    vendorProfile: "https://ibb.co/HZChXdZ",
    review: 126,
    chargerType:"AC(fast)",
    latitude: 28.51399217344444,
    longitude: 77.39209988640668,
    imageUrls: [
      "https://ibb.co/4gZwZCzS",
      "https://ibb.co/nMHmmTJQ",
      "https://ibb.co/r24BWF35",
    ],
  ),
  Place(
    isActive: true,
    title: "Sector 62 EV Hub",
    image: "https://ibb.co/PZ7cTLy2",
    rating: 4.2,
    time: "9AM–9PM",
    price: 13,
    address: "Sector 62, Noida",
    vendor: "Anjali",
    vendorProfile: "https://ibb.co/anjaliprofile",
    review: 98,
    chargerType:"AC(slow)",
    latitude: 28.6100,
    longitude: 77.3700,
    imageUrls: ["https://ibb.co/PZ7cTLy2", "https://ibb.co/dFwL6ts"],
  ),
  Place(
    isActive: true,
    title: "Sector 53 Charging Point",
    image: "https://ibb.co/Lmb38sj",
    rating: 4.0,
    time: "10AM–8PM",
    price: 14,
    address: "Sector 53, Noida",
    vendor: "Rahul",
    vendorProfile: "https://ibb.co/rahulprofile",
    review: 85,
    chargerType:"DC",
    latitude: 28.5911007,
    longitude: 77.3628053,
    imageUrls: [
      "https://ibb.co/Lmb38sj",
      "https://ibb.co/PZ7cTLy2",
      "https://ibb.co/whH7qgnB",
    ],
  ),
];
