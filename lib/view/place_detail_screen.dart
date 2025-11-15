import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evconnect/Components/my_icon_button.dart';
import 'package:evconnect/Components/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:evconnect/provider/favourite_provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  int currentIndex = 0;
  GoogleMapController? _detailMapController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Provider = FavouriteProvider.of(context);
    // Read rating safely and convert to double for decisions and widgets
    final dynamic _rawRating = widget.place['rating'];
    double ratingValue;
    if (_rawRating is num) {
      ratingValue = _rawRating.toDouble();
    } else if (_rawRating is String) {
      ratingValue = double.tryParse(_rawRating) ?? 0.0;
    } else {
      ratingValue = 0.0;
    }

    // Read other place fields defensively and normalize types for UI
    final data = widget.place;
    final String title = data['title']?.toString() ?? '';
    final String address = data['address']?.toString() ?? '';
    final String time = data['time']?.toString() ?? '';
    final int price =
        (data['price'] is int)
            ? data['price'] as int
            : int.tryParse(data['price']?.toString() ?? '') ?? 0;
    final String vendor = data['vendor']?.toString() ?? '';
    final String vendorProfile = data['vendorProfile']?.toString() ?? '';
    final int reviewCount =
        (data['review'] is int)
            ? data['review'] as int
            : int.tryParse(data['review']?.toString() ?? '') ?? 0;
    final String chargerType = data['chargerType']?.toString() ?? '';
    final double latitude =
        (data['latitude'] is num)
            ? (data['latitude'] as num).toDouble()
            : double.tryParse(data['latitude']?.toString() ?? '') ?? 0.0;
    final double longitude =
        (data['longitude'] is num)
            ? (data['longitude'] as num).toDouble()
            : double.tryParse(data['longitude']?.toString() ?? '') ?? 0.0;
    final List<String> imageUrls =
        (data['imageUrls'] as List?)
            ?.map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        <String>[];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailImageandIcon(size, context, imageUrls, Provider),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "Charger in ${widget.place['address']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.place['time'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Always show the rating / badge box on the detail screen
            ratingAndStarTrue(ratingValue),
            SizedBox(height: size.height * 0.02),
            // Additional detail components: price, host, charger type, address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "\₹$price",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(
                              text: " /kWh",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: implement booking flow
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Text(
                            'Reserve',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        backgroundImage:
                            vendorProfile.isNotEmpty
                                ? NetworkImage(vendorProfile) as ImageProvider
                                : null,
                        child:
                            vendorProfile.isEmpty
                                ? const Icon(
                                  Icons.person,
                                  color: Colors.black54,
                                )
                                : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendor.isNotEmpty ? vendor : 'Host',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              chargerType.isNotEmpty ? chargerType : 'Charger',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            reviewCount.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Reviews',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          address,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.black12),
                  const SizedBox(height: 8),
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16),
                          const SizedBox(width: 8),
                          Text('Hours: $time'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.electrical_services, size: 16),
                          const SizedBox(width: 8),
                          Text('Charger: $chargerType'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.monetization_on, size: 16),
                          const SizedBox(width: 8),
                          Text('Price: \₹$price / kWh'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.pin_drop, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Coordinates: ${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // "Where you'll be" map preview (moved below Details)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where you\'ll be',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          (latitude != 0.0 || longitude != 0.0)
                              ? GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(latitude, longitude),
                                  zoom: 15,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId('place_marker'),
                                    position: LatLng(latitude, longitude),
                                  ),
                                },
                                myLocationEnabled: false,
                                zoomControlsEnabled: false,
                                liteModeEnabled: true,
                                onMapCreated: (controller) {
                                  _detailMapController = controller;
                                },
                              )
                              : Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Text('Location not available'),
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // Removed the "Book a slot" CTA per request
          ],
        ),
      ),
    );
  }

  Container ratingAndStarTrue(double rating) {
    // choose badge text based on rating
    final String badgeText =
        rating >= 4.5
            ? 'Top-Rated\nStation'
            : rating >= 4.0
            ? 'Verified\nStation'
            : rating >= 3.5
            ? 'Popular\nSpot'
            : 'Private\nCharger';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                rating.toString(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              StarRating(rating: rating),
            ],
          ),
          // Replace Stack+Positioned with Padding to avoid layout issues
          // Center the badge text in the middle column
          Expanded(
            child: Center(
              child: Text(
                badgeText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                widget.place['review'].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Text(
                "Reviews",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack detailImageandIcon(
    Size size,
    BuildContext context,
    List<String> imageUrls,
    Provider,
  ) {
    // Ensure the Stack has a finite height so it can be laid out inside
    // a SingleChildScrollView / Column without causing an infinite-size
    // assertion in the framework.
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.35,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnotherCarousel(
                  images:
                      imageUrls.isNotEmpty
                          ? imageUrls.map((url) => NetworkImage(url)).toList()
                          : [],
                  showIndicator: false,
                  dotBgColor: Colors.transparent,
                  onImageChange: (p0, p1) {
                    setState(() {
                      currentIndex = p1;
                    });
                  },
                  autoplay: true,
                  boxFit: BoxFit.cover,
                ),
              ),
              // overlays (positioned) go here
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black45,
            ),
            child: Text(
              "${currentIndex + 1} / ${(widget.place['imageUrls'] as List?)?.length ?? 0}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 25,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const MyIconButton(icon: Icons.arrow_back_ios_new),
                ),
                SizedBox(width: size.width * 0.55),
                const MyIconButton(icon: Icons.share_outlined),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    Provider.toggleFavourite(widget.place);
                  },
                  child: MyIconButton(
                    icon:
                        Provider.isExist(widget.place)
                            ? Icons.favorite
                            : Icons.favorite_border,
                    iconColor:
                        Provider.isExist(widget.place)
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
