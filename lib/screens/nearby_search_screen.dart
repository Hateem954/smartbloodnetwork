// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NearbySearchScreen extends StatefulWidget {
//   const NearbySearchScreen({super.key});

//   @override
//   State<NearbySearchScreen> createState() => _NearbySearchScreenState();
// }

// class _NearbySearchScreenState extends State<NearbySearchScreen> {
//   Position? userPosition;

//   String selectedBloodGroup = "All";
//   String searchQuery = "";
//   double selectedDistance = 15;

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return;

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }

//     userPosition = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {});
//   }

//   double distanceKm(double lat1, double lon1, double lat2, double lon2) {
//     const R = 6371;

//     final dLat = (lat2 - lat1) * pi / 180;
//     final dLon = (lon2 - lon1) * pi / 180;

//     final a =
//         sin(dLat / 2) * sin(dLat / 2) +
//         cos(lat1 * pi / 180) *
//             cos(lat2 * pi / 180) *
//             sin(dLon / 2) *
//             sin(dLon / 2);

//     return R * (2 * atan2(sqrt(a), sqrt(1 - a)));
//   }

//   Future<void> _call(String phone) async {
//     final Uri url = Uri.parse("tel:$phone");
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (userPosition == null) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Search Donors & Hospitals"),
//         backgroundColor: Colors.red,
//       ),

//       body: Column(
//         children: [
//           // 🔍 SEARCH + FILTER SECTION
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 // SEARCH BAR (HOSPITAL / NAME)
//                 TextField(
//                   onChanged: (value) {
//                     setState(() => searchQuery = value.toLowerCase());
//                   },
//                   decoration: const InputDecoration(
//                     labelText: "Search Hospital or Donor",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // BLOOD GROUP FILTER
//                 DropdownButtonFormField<String>(
//                   value: selectedBloodGroup,
//                   items:
//                       ["All", "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
//                           .map(
//                             (e) => DropdownMenuItem(value: e, child: Text(e)),
//                           )
//                           .toList(),
//                   onChanged: (value) {
//                     setState(() => selectedBloodGroup = value!);
//                   },
//                   decoration: const InputDecoration(
//                     labelText: "Blood Group",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // DISTANCE SLIDER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [Text("Distance: ${selectedDistance.toInt()} KM")],
//                 ),

//                 Slider(
//                   value: selectedDistance,
//                   min: 5,
//                   max: 50,
//                   divisions: 9,
//                   onChanged: (value) {
//                     setState(() => selectedDistance = value);
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const Divider(),

//           // 📡 DATA LIST
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("users") // donors + hospitals
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final docs = snapshot.data!.docs;

//                 final filtered = docs.where((doc) {
//                   final data = doc.data() as Map<String, dynamic>;

//                   final name = (data["name"] ?? data["hospitalName"] ?? "")
//                       .toString()
//                       .toLowerCase();

//                   final bloodGroup = data["bloodGroup"] ?? "";

//                   final lat = (data["latitude"] ?? 0).toDouble();
//                   final lng = (data["longitude"] ?? 0).toDouble();

//                   final distance = distanceKm(
//                     userPosition!.latitude,
//                     userPosition!.longitude,
//                     lat,
//                     lng,
//                   );

//                   // 🔍 SEARCH FILTER
//                   final searchMatch =
//                       searchQuery.isEmpty || name.contains(searchQuery);

//                   // 🩸 BLOOD FILTER
//                   final bloodMatch =
//                       selectedBloodGroup == "All" ||
//                       bloodGroup == selectedBloodGroup;

//                   // 📍 DISTANCE FILTER
//                   final distanceMatch = distance <= selectedDistance;

//                   return searchMatch && bloodMatch && distanceMatch;
//                 }).toList();

//                 if (filtered.isEmpty) {
//                   return const Center(child: Text("No results found"));
//                 }

//                 return ListView.builder(
//                   itemCount: filtered.length,
//                   itemBuilder: (context, index) {
//                     final data = filtered[index].data() as Map<String, dynamic>;

//                     final isAvailable = data["availability"] == true;

//                     return Card(
//                       margin: const EdgeInsets.all(8),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: isAvailable
//                               ? Colors.green
//                               : Colors.grey,
//                           child: const Icon(
//                             Icons.local_hospital,
//                             color: Colors.white,
//                           ),
//                         ),

//                         title: Text(
//                           data["name"] ?? data["hospitalName"] ?? "Unknown",
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),

//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("🩸 ${data["bloodGroup"] ?? ""}"),
//                             Text(
//                               "📍 ${distanceKm(userPosition!.latitude, userPosition!.longitude, data["latitude"] ?? 0, data["longitude"] ?? 0).toStringAsFixed(1)} KM away",
//                             ),
//                             Text(
//                               isAvailable ? "🟢 Available" : "🔴 Not Available",
//                             ),
//                           ],
//                         ),

//                         trailing: IconButton(
//                           icon: const Icon(Icons.call, color: Colors.red),
//                           onPressed: () {
//                             _call(data["phone"] ?? "");
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbySearchScreen extends StatefulWidget {
  const NearbySearchScreen({super.key});

  @override
  State<NearbySearchScreen> createState() => _NearbySearchScreenState();
}

class _NearbySearchScreenState extends State<NearbySearchScreen> {
  Position? userPosition;

  bool loading = true;
  String? errorMessage;

  List<Map<String, dynamic>> allData = [];

  String searchQuery = "";
  String selectedBloodGroup = "All";
  double selectedDistance = 20;

  final List<String> bloodGroups = [
    "All",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await getLocation();
      await fetchAllData();
    } catch (e) {
      errorMessage = "Failed to load data: $e";
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  /// Returns false if location could not be obtained, so the caller
  /// can show a real message instead of spinning forever.
  Future<bool> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      errorMessage = "Location services are turned off.";
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        errorMessage = "Location permission denied.";
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      errorMessage =
          "Location permission permanently denied. Enable it in app settings.";
      return false;
    }

    try {
      userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return true;
    } catch (e) {
      errorMessage = "Could not get current location: $e";
      return false;
    }
  }

  /// Safely reads a numeric field. Returns 0.0 if missing, null, or wrong type.
  double _readDouble(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is num) return value.toDouble();
    return 0.0;
  }

  Future<void> fetchAllData() async {
    allData.clear();

    /// ---------------- DONORS ----------------
    try {
      final donorSnapshot = await FirebaseFirestore.instance
          .collection("donors")
          .get();

      for (var doc in donorSnapshot.docs) {
        final data = doc.data();

        allData.add({
          "type": "Donor",
          "title": data["location"] ?? "",
          "subtitle": data["blood_group"] ?? "",
          "phone": data["contact"] ?? "",
          "availability": data["availability"] == "Available",
          "bloodGroup": data["blood_group"] ?? "",
          // Read real coordinates if present instead of hardcoding 0.0,
          // otherwise donors never get distance-filtered or sorted correctly.
          "latitude": _readDouble(data, "latitude"),
          "longitude": _readDouble(data, "longitude"),
          "raw": data,
        });
      }
    } catch (e) {
      debugPrint("Error fetching donors: $e");
    }

    /// ---------------- HOSPITALS ----------------
    try {
      final hospitalSnapshot = await FirebaseFirestore.instance
          .collection("hospitals")
          .get();

      for (var doc in hospitalSnapshot.docs) {
        final data = doc.data();

        allData.add({
          "type": "Hospital",
          "title": data["name"] ?? "",
          "subtitle": data["address"] ?? "",
          "phone": data["phone"] ?? "",
          "availability": data["verified"] == true,
          "bloodGroup": "",
          "latitude": _readDouble(data, "latitude"),
          "longitude": _readDouble(data, "longitude"),
          "raw": data,
        });
      }
    } catch (e) {
      debugPrint("Error fetching hospitals: $e");
    }

    /// ---------------- EMERGENCY REQUESTS ----------------
    try {
      final emergencySnapshot = await FirebaseFirestore.instance
          .collection("emergency_requests")
          .get();

      for (var doc in emergencySnapshot.docs) {
        final data = doc.data();

        allData.add({
          "type": "Emergency",
          "title": data["hospital"] ?? "",
          "subtitle": data["patientName"] ?? "",
          "phone": data["phone"] ?? "",
          "availability": true,
          "bloodGroup": data["bloodGroup"] ?? "",
          "latitude": _readDouble(data, "latitude"),
          "longitude": _readDouble(data, "longitude"),
          "raw": data,
        });
      }
    } catch (e) {
      debugPrint("Error fetching emergency requests: $e");
    }
  }

  double distanceKm(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371;

    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);

    return R * (2 * atan2(sqrt(a), sqrt(1 - a)));
  }

  Future<void> callNumber(String phone) async {
    if (phone.isEmpty) return;

    final Uri uri = Uri.parse("tel:$phone");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> openInMaps(double lat, double lng, String label) async {
    if (lat == 0 && lng == 0) return;

    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Show a real error instead of an infinite spinner if location failed.
    if (userPosition == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Nearby Search"),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_off, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  errorMessage ?? "Could not determine your location.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                      errorMessage = null;
                    });
                    loadData();
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Rule 1: nothing is shown until the user types a search term.
    final bool hasSearch = searchQuery.trim().isNotEmpty;
    final bool bloodFilterActive = selectedBloodGroup != "All";

    List<Map<String, dynamic>> filtered = [];

    if (hasSearch) {
      filtered = allData.where((item) {
        final title = item["title"].toString().toLowerCase();
        final subtitle = item["subtitle"].toString().toLowerCase();
        final blood = item["bloodGroup"].toString();
        final query = searchQuery.toLowerCase();

        final searchMatch = title.contains(query) || subtitle.contains(query);

        if (!searchMatch) return false;

        // Rule 2: name search alone ignores blood group and distance —
        // matches show nationwide.
        if (!bloodFilterActive) return true;

        // Rule 3: once a blood group is picked, distance starts to matter.
        // Hospitals have no blood group field, so they are not excluded
        // by this filter — only donors/emergency requests are checked.
        final bloodMatch =
            item["type"] == "Hospital" || blood == selectedBloodGroup;

        if (!bloodMatch) return false;

        final lat = (item["latitude"] as num).toDouble();
        final lng = (item["longitude"] as num).toDouble();

        if (lat == 0 && lng == 0) return true; // no coordinates, can't filter

        final distance = distanceKm(
          userPosition!.latitude,
          userPosition!.longitude,
          lat,
          lng,
        );

        return distance <= selectedDistance;
      }).toList();

      // Only sort by distance once distance is actually in play.
      if (bloodFilterActive) {
        filtered.sort((a, b) {
          double d1 = 99999;
          double d2 = 99999;

          if (a["latitude"] != 0) {
            d1 = distanceKm(
              userPosition!.latitude,
              userPosition!.longitude,
              a["latitude"],
              a["longitude"],
            );
          }

          if (b["latitude"] != 0) {
            d2 = distanceKm(
              userPosition!.latitude,
              userPosition!.longitude,
              b["latitude"],
              b["longitude"],
            );
          }

          return d1.compareTo(d2);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Search"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Search donor, hospital or patient",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedBloodGroup,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Blood Group",
                  ),
                  items: bloodGroups
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBloodGroup = value!;
                    });
                  },
                ),
                const SizedBox(height: 15),
                Opacity(
                  // Distance only has an effect once a blood group is
                  // selected. Grayed out otherwise so it doesn't look
                  // like it's filtering when it isn't.
                  opacity: bloodFilterActive ? 1.0 : 0.4,
                  child: IgnorePointer(
                    ignoring: !bloodFilterActive,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              bloodFilterActive
                                  ? "Distance : ${selectedDistance.toInt()} KM"
                                  : "Distance : select a blood group to enable",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          min: 5,
                          max: 100,
                          divisions: 19,
                          value: selectedDistance,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              selectedDistance = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      hasSearch ? "No Results Found" : "Type a name to search",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];

                      final bool available = item["availability"];

                      double distance = 0;

                      if (item["latitude"] != 0 && item["longitude"] != 0) {
                        distance = distanceKm(
                          userPosition!.latitude,
                          userPosition!.longitude,
                          item["latitude"],
                          item["longitude"],
                        );
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: available
                                ? Colors.green
                                : Colors.grey,
                            child: Icon(
                              item["type"] == "Donor"
                                  ? Icons.person
                                  : item["type"] == "Hospital"
                                  ? Icons.local_hospital
                                  : Icons.warning,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            // When a blood group filter is active, a donor's
                            // exact identity (their name/location string) is
                            // hidden — only their blood group and contact
                            // route stay visible. Hospitals and emergency
                            // requests are unaffected since they are not
                            // personal donor identities.
                            (bloodFilterActive && item["type"] == "Donor")
                                ? "Donor (${item["bloodGroup"]})"
                                : item["title"].toString(),
                          ),
                          subtitle: Text(
                            (bloodFilterActive && item["type"] == "Donor")
                                ? "${item["latitude"] != 0 ? "${distance.toStringAsFixed(1)} km away" : "Distance unknown"}"
                                : "${item["subtitle"]}"
                                      "${item["bloodGroup"].toString().isNotEmpty ? " • ${item["bloodGroup"]}" : ""}"
                                      "${item["latitude"] != 0 ? " • ${distance.toStringAsFixed(1)} km" : ""}",
                          ),
                          trailing: item["type"] == "Hospital"
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.directions,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => openInMaps(
                                    item["latitude"],
                                    item["longitude"],
                                    item["title"].toString(),
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      callNumber(item["phone"].toString()),
                                ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
