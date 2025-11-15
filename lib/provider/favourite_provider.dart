import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> _favouriteIds = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> get favorites => _favouriteIds;

  FavouriteProvider() {
    loadFavourite();
  }

  void toggleFavourite(DocumentSnapshot place) async {
    String placeId = place.id;
    if (_favouriteIds.contains(placeId)) {
      _favouriteIds.remove(placeId);
      await _removeFavorite(placeId);
    } else {
      _favouriteIds.add(placeId);
      await _addFavorites(placeId);
    }
    notifyListeners();
  }

  bool isExist(DocumentSnapshot place) {
    return _favouriteIds.contains(place.id);
  }

  Future<void> _addFavorites(String placeId) async {
    try {
      await firebaseFirestore
          .collection("userFavorites")
          .doc(placeId)
          .set({'isFavourite': true,});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _removeFavorite(String placeId) async {
    try {
      await firebaseFirestore
          .collection("userFavorites")
          .doc(placeId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadFavourite() async {
    try {
      QuerySnapshot snapshot =
          await firebaseFirestore.collection("userFavorites").get();
      _favouriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  static FavouriteProvider of(BuildContext context,{bool listen = true}) {
    return Provider.of<FavouriteProvider>(
      context, 
      listen: listen,
      );
  }
}
