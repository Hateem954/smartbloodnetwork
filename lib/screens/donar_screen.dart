import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorRegistrationScreen extends StatefulWidget {
  const DonorRegistrationScreen({super.key});

  @override
  State<DonorRegistrationScreen> createState() =>
      _DonorRegistrationScreenState();
}

class _DonorRegistrationScreenState extends State<DonorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? bloodGroup;
  String? gender;
  String availabilityStatus = "Available";

  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController medicalInfoController = TextEditingController();

  DateTime? lastDonationDate;

  List<String> bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  List<String> genders = ["Male", "Female", "Other"];

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        lastDonationDate = picked;
      });
    }
  }

  /// ✅ FIXED FIRESTORE SAVE FUNCTION
  Future<void> submitForm() async {


     final prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString("uid") ?? "";

    if (uid.isEmpty) {
      throw Exception("UID not found");
    } 

    if (!_formKey.currentState!.validate()) return;

    try {
      // await FirebaseFirestore.instance.collection("donors").add({
      await FirebaseFirestore.instance.collection("donors").doc(uid).set({
        "uid": uid,
        "blood_group": bloodGroup,
        "age": ageController.text.trim(),
        "gender": gender,
        "city": cityController.text.trim(),
        "location": locationController.text.trim(),
        "contact": contactController.text.trim(),
        "last_donation_date": lastDonationDate != null
            ? lastDonationDate!.toIso8601String()
            : null,
        "availability": availabilityStatus,
        "medical_info": medicalInfoController.text.trim(),
        "created_at": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Donor Registered Successfully")),
      );

      _formKey.currentState!.reset();
      setState(() {
        bloodGroup = null;
        gender = null;
        availabilityStatus = "Available";
        lastDonationDate = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor Registration"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// BLOOD GROUP
              DropdownButtonFormField(
                value: bloodGroup,
                decoration: const InputDecoration(
                  labelText: "Blood Group",
                  border: OutlineInputBorder(),
                ),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => bloodGroup = val),
                validator: (value) =>
                    value == null ? "Select Blood Group" : null,
              ),

              const SizedBox(height: 12),

              /// AGE
              buildTextField(
                label: "Age",
                controller: ageController,
                type: TextInputType.number,
              ),

              /// GENDER
              DropdownButtonFormField(
                value: gender,
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                items: genders
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => gender = val),
                validator: (value) => value == null ? "Select Gender" : null,
              ),

              const SizedBox(height: 12),

              /// CITY
              buildTextField(label: "City", controller: cityController),

              /// LOCATION
              buildTextField(label: "Location", controller: locationController),

              /// CONTACT
              buildTextField(
                label: "Contact Information",
                controller: contactController,
                type: TextInputType.phone,
              ),

              /// LAST DONATION DATE
              ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  lastDonationDate == null
                      ? "Last Donation Date"
                      : "Last Donation: ${lastDonationDate!.toLocal()}".split(
                          ' ',
                        )[0],
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: pickDate,
              ),

              const SizedBox(height: 12),

              /// AVAILABILITY
              SwitchListTile(
                title: const Text("Available for Donation"),
                value: availabilityStatus == "Available",
                onChanged: (val) {
                  setState(() {
                    availabilityStatus = val ? "Available" : "Not Available";
                  });
                },
              ),

              /// MEDICAL INFO
              buildTextField(
                label: "Medical Eligibility Information",
                controller: medicalInfoController,
              ),

              const SizedBox(height: 20),

              /// SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: submitForm,
                  child: const Text("Register as Donor"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
