import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evconnect/Components/search_bar_and_filter.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection("myAppCategory");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchBarAndFilter(),
            StreamBuilder(
              stream: categoryCollection.snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return Stack(
                    children: [
                      Positioned(
                        left: 0, right: 0, top: 80,
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.12,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context,index){
                            return GestureDetector();
                          }
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
