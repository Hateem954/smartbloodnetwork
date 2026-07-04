import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String gender = "Male";
  String bloodGroup = "A+";
  String status = "";
  String uid = "";

  bool isLoading = true;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      uid = prefs.getString("uid") ?? "";

      if (uid.isEmpty) return;

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (doc.exists) {
        fullNameController.text = doc["fullName"] ?? "";
        phoneController.text = doc["phone"] ?? "";
        dobController.text = doc["dob"] ?? "";
        locationController.text = doc["location"] ?? "";

        gender = doc["gender"] ?? "Male";
        bloodGroup = doc["bloodGroup"] ?? "A+";
        status = doc["status"] ?? "";

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isUpdating = true;
    });

    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "fullName": fullNameController.text.trim(),
        "phone": phoneController.text.trim(),
        "dob": dobController.text.trim(),
        "location": locationController.text.trim(),
        "gender": gender,
        "bloodGroup": bloodGroup,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated Successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    setState(() {
      isUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  const CircleAvatar(
                    radius: 45,
                    child: Icon(Icons.person, size: 50),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      labelText: "Date of Birth",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: gender,
                    decoration: const InputDecoration(
                      labelText: "Gender",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Male",
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: "Female",
                        child: Text("Female"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: bloodGroup,
                    decoration: const InputDecoration(
                      labelText: "Blood Group",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: "A+", child: Text("A+")),
                      DropdownMenuItem(value: "A-", child: Text("A-")),
                      DropdownMenuItem(value: "B+", child: Text("B+")),
                      DropdownMenuItem(value: "B-", child: Text("B-")),
                      DropdownMenuItem(value: "AB+", child: Text("AB+")),
                      DropdownMenuItem(value: "AB-", child: Text("AB-")),
                      DropdownMenuItem(value: "O+", child: Text("O+")),
                      DropdownMenuItem(value: "O-", child: Text("O-")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        bloodGroup = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Status : $status",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isUpdating ? null : updateProfile,
                      child: isUpdating
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Update Profile",
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    locationController.dispose();
    super.dispose();
  }
}