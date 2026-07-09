import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_blood_network/screens/hospital_detail_screen.dart';

class AllHospitalsScreen extends StatelessWidget {
  const AllHospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verified Hospitals"),
        backgroundColor: Colors.red,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("hospitals")
            .where("verified", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No verified hospitals found."));
          }

          final hospitals = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final data = hospitals[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.local_hospital, color: Colors.white),
                  ),

                  title: Text(
                    data["name"] ?? "Unknown Hospital",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(data["address"] ?? ""),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HospitalDetailScreen(
                          name: data["name"] ?? "",
                          address: data["address"] ?? "",
                          phone: data["phone"] ?? "",
                          latitude: data["latitude"],
                          longitude: data["longitude"],
                          verified: data["verified"] ?? false,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
