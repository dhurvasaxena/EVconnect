import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evconnect/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wishlists extends StatelessWidget {
  const Wishlists({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider = FavouriteProvider.of(context);
    final favoriteItems = Provider.favorites;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Wishlists",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              favoriteItems.isEmpty
                  ? Text(
                      "No items in your wishlist.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                  )
                  : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.builder(
                      itemCount: favoriteItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8, mainAxisSpacing: 8,
                        ),
                       itemBuilder: (context, index) {
                          String favorite = favoriteItems[index];
                          return FutureBuilder(
                            future: FirebaseFirestore.instance.collection("myAppCollection").doc(favorite).get(),
                            builder: (context,snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              var favoriteItems = snapshot.data!;
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        favoriteItems['image'],
                                      ),
                                    ),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,left: 8,right: 8,
                                    child: Container(
                                      color: Colors.black.withOpacity(0.6),
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        favoriteItems['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                            );
                       }
                       ),
                  )

            ],
          ),
        ),
      ),
    );
  }
}
