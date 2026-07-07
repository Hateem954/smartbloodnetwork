// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class GoogleMapPage extends StatefulWidget {
//   final List<String>? doctorRecommendations; // ✅ Nullable

//   const GoogleMapPage({super.key, this.doctorRecommendations});

//   @override
//   State<GoogleMapPage> createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPage> {
//   GoogleMapController? _controller;
//   Position? _currentPosition;
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polylines = {};
//   final TextEditingController _searchController = TextEditingController();

//   static const String _geoapifyKey = '5a5fd3d21928495b801e02bcd6d3c4f0';
//   LatLng? _selectedDestination;
//   String? _selectedPlaceName;

//   final Map<String, String> _healthcareCategoryMap = {
//     "hospital": "healthcare.hospital",
//     "clinic": "healthcare.clinic",
//     "doctor": "healthcare.doctor",
//     "dentist": "healthcare.dentist",
//     "pharmacy": "healthcare.pharmacy",
//     "optician": "healthcare.optician",
//     "laboratory": "healthcare.laboratory",
//     "rehabilitation": "healthcare.rehabilitation",
//     "veterinary": "healthcare.veterinary",
//     "blood donation": "healthcare.blood_donation",
//     "ambulance": "healthcare.ambulance_station",
//     "nursing home": "healthcare.nursing_home",
//     "hospice": "healthcare.hospice",
//     "therapist": "healthcare.therapist",
//     "psychotherapist": "healthcare.psychotherapist",
//     "general physician": "healthcare.doctor",
//     "health coach": "healthcare.therapist",
//   };

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   /// ✅ Get current location
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }
//     if (permission == LocationPermission.deniedForever) return;

//     final position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       _currentPosition = position;
//       _markers.clear();
//       _markers.add(
//         Marker(
//           markerId: const MarkerId("currentLocation"),
//           position: LatLng(position.latitude, position.longitude),
//           infoWindow: const InfoWindow(title: "You are here"),
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueAzure,
//           ),
//         ),
//       );
//     });

//     _controller?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(position.latitude, position.longitude),
//           zoom: 14.5,
//         ),
//       ),
//     );

//     // ✅ Only auto-search if recommendations exist
//     if (widget.doctorRecommendations != null &&
//         widget.doctorRecommendations!.isNotEmpty) {
//       Future.delayed(const Duration(seconds: 1), _searchAllRecommendations);
//     }
//   }

//   /// ✅ Auto-search all doctor recommendations
//   Future<void> _searchAllRecommendations() async {
//     if (_currentPosition == null) return;

//     for (var rec in widget.doctorRecommendations!) {
//       await _searchNearbyHealthcare(rec);
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "Found nearby places for ${widget.doctorRecommendations!.join(', ')}",
//         ),
//       ),
//     );
//   }

//   /// ✅ Search nearby healthcare
//   Future<void> _searchNearbyHealthcare(String? searchQuery) async {
//     if (_currentPosition == null) return;

//     final query = (searchQuery ?? _searchController.text).trim().toLowerCase();
//     if (query.isEmpty) return;

//     String category =
//         _healthcareCategoryMap.entries
//             .firstWhere(
//               (entry) => query.contains(entry.key),
//               orElse: () => const MapEntry("healthcare", "healthcare.hospital"),
//             )
//             .value;

//     final lat = _currentPosition!.latitude;
//     final lon = _currentPosition!.longitude;

//     final url =
//         'https://api.geoapify.com/v2/places?categories=$category&filter=circle:$lon,$lat,5000&limit=10&apiKey=$_geoapifyKey';

//     try {
//       final response = await http.get(Uri.parse(url));
//       final data = jsonDecode(response.body);
//       List? features = data['features'] as List?;

//       if (features == null || features.isEmpty) {
//         debugPrint("⚠️ No results found for $query");
//         return;
//       }

//       final newMarkers = <Marker>{};
//       for (var feature in features) {
//         final props = feature['properties'];
//         final name = props['name'] ?? 'Unknown Facility';
//         final lat = feature['geometry']['coordinates'][1];
//         final lng = feature['geometry']['coordinates'][0];
//         final address = props['formatted'] ?? '';

//         newMarkers.add(
//           Marker(
//             markerId: MarkerId('place_$lat$lng'),
//             position: LatLng(lat, lng),
//             infoWindow: InfoWindow(title: name, snippet: address),
//             icon: BitmapDescriptor.defaultMarkerWithHue(
//               BitmapDescriptor.hueRed,
//             ),
//             onTap: () {
//               setState(() {
//                 _selectedDestination = LatLng(lat, lng);
//                 _selectedPlaceName = name;
//               });
//               _showNavigateDialog(name);
//             },
//           ),
//         );
//       }

//       setState(() {
//         _markers.addAll(newMarkers);
//       });

//       // Move camera to first result
//       _controller?.animateCamera(
//         CameraUpdate.newLatLngZoom(
//           LatLng(
//             features.first['geometry']['coordinates'][1],
//             features.first['geometry']['coordinates'][0],
//           ),
//           13,
//         ),
//       );
//     } catch (e) {
//       debugPrint("Search error: $e");
//     }
//   }

//   /// ✅ Show "Navigate" dialog
//   void _showNavigateDialog(String placeName) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: Text('Navigate to $placeName?'),
//             content: const Text('Would you like to see the route on the map?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   _createRoute();
//                 },
//                 child: const Text('Navigate'),
//               ),
//             ],
//           ),
//     );
//   }

//   /// ✅ Create driving route
//   Future<void> _createRoute() async {
//     if (_currentPosition == null || _selectedDestination == null) return;

//     final url =
//         'https://api.geoapify.com/v1/routing?waypoints=${_currentPosition!.latitude},${_currentPosition!.longitude}|${_selectedDestination!.latitude},${_selectedDestination!.longitude}&mode=drive&apiKey=$_geoapifyKey';

//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final coords =
//             data['features'][0]['geometry']['coordinates'][0] as List;
//         final routePoints = coords.map((c) => LatLng(c[1], c[0])).toList();

//         setState(() {
//           _polylines.clear();
//           _polylines.add(
//             Polyline(
//               polylineId: const PolylineId('route'),
//               width: 6,
//               color: Colors.blueAccent,
//               points: routePoints,
//             ),
//           );
//         });

//         _fitMapToRoute(
//           LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//           _selectedDestination!,
//         );
//       }
//     } catch (e) {
//       debugPrint("Route error: $e");
//     }
//   }

//   void _fitMapToRoute(LatLng start, LatLng end) {
//     LatLngBounds bounds = LatLngBounds(
//       southwest: LatLng(
//         start.latitude < end.latitude ? start.latitude : end.latitude,
//         start.longitude < end.longitude ? start.longitude : end.longitude,
//       ),
//       northeast: LatLng(
//         start.latitude > end.latitude ? start.latitude : end.latitude,
//         start.longitude > end.longitude ? start.longitude : end.longitude,
//       ),
//     );
//     _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasRecommendations =
//         widget.doctorRecommendations != null &&
//         widget.doctorRecommendations!.isNotEmpty;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           if (_currentPosition == null)
//             const Center(child: CircularProgressIndicator())
//           else
//             GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   _currentPosition!.latitude,
//                   _currentPosition!.longitude,
//                 ),
//                 zoom: 14.5,
//               ),
//               onMapCreated: (controller) => _controller = controller,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               markers: _markers,
//               polylines: _polylines,
//             ),

//           // 🔍 Show Search Bar ONLY if no doctor recommendations
//           if (!hasRecommendations)
//             Positioned(
//               top: 40,
//               left: 15,
//               right: 15,
//               child: Material(
//                 elevation: 6,
//                 borderRadius: BorderRadius.circular(10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: const InputDecoration(
//                           hintText:
//                               "Search healthcare (e.g. hospital, dentist)",
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.search, color: Colors.redAccent),
//                       onPressed:
//                           () => _searchNearbyHealthcare(
//                             _searchController.text.trim(),
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//           // ✅ Show chips ONLY if recommendations exist
//           if (hasRecommendations)
//             Positioned(
//               bottom: 20,
//               left: 0,
//               right: 0,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   children:
//                       widget.doctorRecommendations!
//                           .map(
//                             (doc) => Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 4,
//                               ),
//                               child: ActionChip(
//                                 label: Text(doc),
//                                 onPressed: () => _searchNearbyHealthcare(doc),
//                                 backgroundColor: Colors.green.shade100,
//                               ),
//                             ),
//                           )
//                           .toList(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCurrentLocation,
//         backgroundColor: Colors.blueAccent,
//         child: const Icon(Icons.my_location, color: Colors.white),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapPage extends StatefulWidget {
  final bool selectMode;

  const GoogleMapPage({super.key, this.selectMode = false});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? _controller;
  Position? _currentPosition;

  final Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();

  static const String _geoapifyKey = '5a5fd3d21928495b801e02bcd6d3c4f0';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable location services.")),
      );
      return;
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Location permission permanently denied. Please enable it from Settings.",
          ),
        ),
      );

      await Geolocator.openAppSettings();
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          14,
        ),
      );
    } catch (e) {
      debugPrint("Location Error: $e");
    }
  }


  Future<Map<String, String>> _getPlaceDetails(double lat, double lng) async {
    final url =
        "https://api.geoapify.com/v1/geocode/reverse?"
        "lat=$lat"
        "&lon=$lng"
        "&apiKey=$_geoapifyKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["features"] != null && data["features"].isNotEmpty) {
        final props = data["features"][0]["properties"];

        return {
          "name": props["name"] ?? props["address_line1"] ?? "Hospital",
          "address": props["formatted"] ?? "",
        };
      }
    }

    return {"name": "Hospital", "address": ""};
  }
  Future<void> _searchHospitals(String query) async {
    if (query.trim().isEmpty) return;

    final url =
        "https://api.geoapify.com/v1/geocode/search?"
        "text=${Uri.encodeComponent(query)}"
        "&filter=countrycode:pk"
        "&limit=10"
        "&apiKey=$_geoapifyKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        debugPrint(response.body);
        return;
      }

      final data = jsonDecode(response.body);

      final List features = data["features"] ?? [];

      setState(() {
        _markers.clear();
      });

      if (features.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("No hospital found.")));
        return;
      }

      for (final feature in features) {
        final props = feature["properties"];

        final double lat = feature["geometry"]["coordinates"][1];
        final double lng = feature["geometry"]["coordinates"][0];

        final String name = props["name"] ?? props["formatted"] ?? "Hospital";

        final String address = props["formatted"] ?? "";

        _markers.add(
          Marker(
            markerId: MarkerId("$lat$lng"),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name, snippet: address),
          onTap: () async {
              // final place = await _getPlaceDetails(lat, lng);

              // if (widget.selectMode) {
              //   Navigator.pop(context, {
              //     "name": place["name"],
              //     "address": place["address"],
              //     "lat": lat,
              //     "lng": lng,
              //   });
              // }
               final place = await _getPlaceDetails(lat, lng);

      Navigator.pop(context,{
        "name": place["name"],
        "address": place["address"],
        "lat": lat,
        "lng": lng,
      });

  
            }
          ),
        );
      }

      setState(() {});

      final first = features.first["geometry"]["coordinates"];

      _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(first[1], first[0]), 15),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
                    zoom: 14,
                  ),
                  onMapCreated: (c) => _controller = c,
                  myLocationEnabled: true,
                  markers: _markers,
                ),

                // 🔍 SEARCH BAR
                Positioned(
                  top: 50,
                  left: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: "Search hospital name...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            _searchHospitals(_searchController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
