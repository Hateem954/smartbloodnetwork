import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyRequestScreen extends StatefulWidget {
  const EmergencyRequestScreen({super.key});

  @override
  State<EmergencyRequestScreen> createState() =>
      _EmergencyRequestScreenState();
}

class _EmergencyRequestScreenState
    extends State<EmergencyRequestScreen> {

  final _formKey = GlobalKey<FormState>();

  final patientController = TextEditingController();
  final hospitalController = TextEditingController();
  final unitsController = TextEditingController();
  final notesController = TextEditingController();

  String bloodGroup = "A+";

  double? latitude;
  double? longitude;

  bool loading = false;

  final List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];

  Future<void> getLocation() async {

    LocationPermission permission =
        await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return;
    }

    Position position =
        await Geolocator.getCurrentPosition();

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Location Added")),
    );
  }


Future<void> submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please share your location.")),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      // Get UID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString("uid") ?? "";

      if (uid.isEmpty) {
        throw Exception("User UID not found.");
      }

      await FirebaseFirestore.instance
          .collection("emergency_requests")
          .doc(uid)
          .set({
            "uid": uid,
            "patientName": patientController.text.trim(),
            "bloodGroup": bloodGroup,
            "units": int.parse(unitsController.text),
            "hospital": hospitalController.text.trim(),
            "notes": notesController.text.trim(),
            "latitude": latitude,
            "longitude": longitude,
            "status": "approved",
            "createdAt": Timestamp.now(),
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Emergency Request Submitted")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Emergency Blood Request"),
        backgroundColor: Colors.red,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(
                controller: patientController,
                decoration: const InputDecoration(
                  labelText: "Patient Name",
                ),
                validator: (v) =>
                    v!.isEmpty ? "Enter Patient Name" : null,
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(

                value: bloodGroup,

                items: bloodGroups.map((e) {

                  return DropdownMenuItem(

                    value: e,

                    child: Text(e),

                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {

                    bloodGroup = value!;

                  });

                },

                decoration: const InputDecoration(

                  labelText: "Required Blood Group",

                ),

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller: unitsController,

                keyboardType: TextInputType.number,

                decoration: const InputDecoration(

                  labelText: "Required Units",

                ),

                validator: (v) =>
                    v!.isEmpty ? "Enter Units" : null,

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller: hospitalController,

                decoration: const InputDecoration(

                  labelText: "Hospital Name",

                ),

                validator: (v) =>
                    v!.isEmpty ? "Enter Hospital Name" : null,

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller: notesController,

                maxLines: 4,

                decoration: const InputDecoration(

                  labelText: "Emergency Notes",

                ),

              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(

                onPressed: getLocation,

                icon: const Icon(Icons.location_on),

                label: Text(

                  latitude == null
                      ? "Share Current Location"
                      : "Location Added",

                ),

              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,

                height: 50,

                child: ElevatedButton(

                  onPressed:
                      loading ? null : submitRequest,

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.red,

                  ),

                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Submit Emergency Request",
                        ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}