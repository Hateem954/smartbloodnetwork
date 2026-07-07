import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailScreen extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final double? latitude;
  final double? longitude;
  final bool verified;

  const HospitalDetailScreen({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    this.latitude,
    this.longitude,
    required this.verified,
  });

  Future<void> _openMap() async {
    if (latitude == null || longitude == null) return;

    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving",
    );

    if (!await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication)) {
      throw "Could not open the map.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Details"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.verified, color: Colors.green),
                const SizedBox(width: 5),
                Text(verified ? "Verified Hospital" : "Not Verified"),
              ],
            ),

            const SizedBox(height: 20),

            const Text("📍 Address"),
            Text(address),

            const SizedBox(height: 15),

            const Text("📞 Phone"),
            Text(phone),

            const SizedBox(height: 15),

            if (latitude != null && longitude != null)
              Text("📍 Location: $latitude, $longitude"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (latitude != null && longitude != null)
                    ? _openMap
                    : null,
                icon: const Icon(Icons.navigation),
                label: const Text("Navigate to Hospital"),
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
