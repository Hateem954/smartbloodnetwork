import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonorsScreen extends StatelessWidget {
  const DonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Donors")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("donors").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final donors = snapshot.data!.docs;

          if (donors.isEmpty) {
            return const Center(child: Text("No Donors Found"));
          }

          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, index) {
              final donor = donors[index];

              return _donorCard(context, donor);
            },
          );
        },
      ),
    );
  }
    Widget _donorCard(BuildContext context, QueryDocumentSnapshot donor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 28, child: Icon(Icons.person)),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donor['uid'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        donor['location'],
                        style: const TextStyle(color: Colors.grey),
                      ),

                      Text(
                        donor['city'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Text(
                      donor['blood_group'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Icon(
                      donor['availability'] == "Available"
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: donor['availability'] == "Available"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showDonorDetails(context, donor);
                },
                child: const Text("View Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDonorDetails(BuildContext context, QueryDocumentSnapshot donor) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Donor Details"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),

                const SizedBox(height: 20),

                _detail("Blood Group", donor['blood_group']),
                _detail("Age", donor['age']),
                _detail("Gender", donor['gender']),
                _detail("City", donor['city']),
                _detail("Location", donor['location']),
                _detail("Contact", donor['contact']),
                _detail("Availability", donor['availability']),
                _detail("Medical Info", donor['medical_info']),
                _detail("Last Donation", donor['last_donation_date']),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$title :",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

}
