import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyWidget extends StatefulWidget {
  const EmergencyWidget({super.key});

  @override
  State<EmergencyWidget> createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget> {
  Position? userPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      userPosition = position;
    });
  }

  double calculateDistanceKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371;

    final dLat = (lat2 - lat1) * 3.141592653589793 / 180;
    final dLon = (lon2 - lon1) * 3.141592653589793 / 180;

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * 3.141592653589793 / 180) *
            cos(lat2 * 3.141592653589793 / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  @override
  Widget build(BuildContext context) {
    if (userPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("emergency_requests")
          .where("status", isEqualTo: "pending")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        // 🔥 FILTER: ONLY 15 KM
        final filtered = docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;

          final lat = (data["latitude"] ?? 0).toDouble();
          final lng = (data["longitude"] ?? 0).toDouble();

          final distance = calculateDistanceKm(
            userPosition!.latitude,
            userPosition!.longitude,
            lat,
            lng,
          );

          return distance <= 15;
        }).toList();

        if (filtered.isEmpty) {
          return const Center(
            child: Text("No emergency requests within 15 KM"),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "🚨 Nearby Emergency Requests (15 KM)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ...filtered.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.bloodtype, color: Colors.white),
                  ),

                  title: Text(
                    data["patientName"] ?? "Unknown User",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text("🩸 Blood Group: ${data["bloodGroup"] ?? ""}"),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  // onTap: () {
                  //   showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(16),
                  //         child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               data["patientName"] ?? "",
                  //               style: const TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //             const SizedBox(height: 10),

                  //             Text("🩸 Blood Group: ${data["bloodGroup"]}"),
                  //             Text("🏥 Hospital: ${data["hospital"]}"),
                  //             Text("💉 Units: ${data["units"]}"),
                  //             Text("📌 Status: ${data["status"]}"),
                  //             Text("📝 Notes: ${data["notes"] ?? ""}"),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   );
                  // },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EmergencyDetailScreen(
                          patientName: data["patientName"] ?? "",
                          bloodGroup: data["bloodGroup"] ?? "",
                          hospital: data["hospital"] ?? "",
                          units: data["units"] ?? 0,
                          status: data["status"] ?? "",
                          notes: data["notes"] ?? "",
                          latitude: data["latitude"],
                          longitude: data["longitude"],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}


class EmergencyDetailScreen extends StatelessWidget {
  final String patientName;
  final String bloodGroup;
  final String hospital;
  final int units;
  final String status;
  final String notes;
  final double? latitude;
  final double? longitude;

  const EmergencyDetailScreen({
    super.key,
    required this.patientName,
    required this.bloodGroup,
    required this.hospital,
    required this.units,
    required this.status,
    required this.notes,
    this.latitude,
    this.longitude,
  });

  Future<void> _openMap() async {
    if (latitude == null || longitude == null) return;

    final Uri url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "Could not open map";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Details"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patientName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("🩸 Blood Group: $bloodGroup"),
            Text("🏥 Hospital: $hospital"),
            Text("💉 Units: $units"),
            Text("📌 Status: $status"),
            Text("📝 Notes: $notes"),

            const SizedBox(height: 10),

            if (latitude != null && longitude != null)
              Text("📍 Location: $latitude, $longitude"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    (latitude != null && longitude != null) ? _openMap : null,
                icon: const Icon(Icons.navigation),
                label: const Text("Navigate to Location"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}