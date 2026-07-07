// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AdminHospitalScreen extends StatefulWidget {
//   const AdminHospitalScreen({super.key});

//   @override
//   State<AdminHospitalScreen> createState() => _AdminHospitalScreenState();
// }

// class _AdminHospitalScreenState extends State<AdminHospitalScreen> {
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();

//   double? latitude;
//   double? longitude;

//   bool isLoading = false;

//   final CollectionReference hospitals = FirebaseFirestore.instance.collection(
//     "hospitals",
//   );

//   // 🟢 ADD HOSPITAL
//   Future<void> addHospital() async {
//     if (nameController.text.isEmpty ||
//         phoneController.text.isEmpty ||
//         addressController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please fill all fields");
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String uid = prefs.getString("uid") ?? "";

//       if (uid.isEmpty) {
//         throw Exception("User UID not found.");
//       }

//       await hospitals.doc(uid).set({
//         "uid": uid,
//         "name": nameController.text.trim(),
//         "phone": phoneController.text.trim(),
//         "address": addressController.text.trim(),
//         "latitude": latitude ?? 0.0,
//         "longitude": longitude ?? 0.0,
//         "verified": false,
//         "createdAt": FieldValue.serverTimestamp(),
//       });

//       Fluttertoast.showToast(msg: "Hospital Added");

//       nameController.clear();
//       phoneController.clear();
//       addressController.clear();
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }

//     setState(() => isLoading = false);
//   }

//   // 🟡 UPDATE HOSPITAL
//   Future<void> updateHospital(String docId, Map<String, dynamic> data) async {
//     await hospitals.doc(docId).update(data);
//     Fluttertoast.showToast(msg: "Hospital Updated");
//   }

//   // 🔴 DELETE HOSPITAL
//   Future<void> deleteHospital(String docId) async {
//     await hospitals.doc(docId).delete();
//     Fluttertoast.showToast(msg: "Hospital Deleted");
//   }

//   // 🟣 TOGGLE VERIFY
//   Future<void> toggleVerify(String docId, bool currentStatus) async {
//     await hospitals.doc(docId).update({"verified": !currentStatus});

//     Fluttertoast.showToast(msg: "Verification Updated");
//   }

//   // 🧠 SHOW ADD DIALOG
//   void showAddDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Add Hospital"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Name"),
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: const InputDecoration(labelText: "Phone"),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: const InputDecoration(labelText: "Address"),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await addHospital();
//               Navigator.pop(context);
//             },
//             child: const Text("Add"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Admin - Hospitals"),
//         actions: [
//           IconButton(icon: const Icon(Icons.add), onPressed: showAddDialog),
//         ],
//       ),

//       body: StreamBuilder<QuerySnapshot>(
//         stream: hospitals.orderBy("createdAt", descending: true).snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           if (docs.isEmpty) {
//             return const Center(child: Text("No hospitals found"));
//           }

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final doc = docs[index];
//               final data = doc.data() as Map<String, dynamic>;

//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(data["name"] ?? ""),
//                   subtitle: Text(data["address"] ?? ""),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // ✔ VERIFY BUTTON
//                       IconButton(
//                         icon: Icon(
//                           data["verified"] == true
//                               ? Icons.verified
//                               : Icons.verified_outlined,
//                           color: data["verified"] == true
//                               ? Colors.green
//                               : Colors.grey,
//                         ),
//                         onPressed: () =>
//                             toggleVerify(doc.id, data["verified"] ?? false),
//                       ),

//                       // ✏ UPDATE BUTTON
//                       IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.blue),
//                         onPressed: () {
//                           nameController.text = data["name"];
//                           phoneController.text = data["phone"];
//                           addressController.text = data["address"];

//                           showDialog(
//                             context: context,
//                             builder: (_) => AlertDialog(
//                               title: const Text("Update Hospital"),
//                               content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   TextField(controller: nameController),
//                                   TextField(controller: phoneController),
//                                   TextField(controller: addressController),
//                                 ],
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text("Cancel"),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     await updateHospital(doc.id, {
//                                       "name": nameController.text,
//                                       "phone": phoneController.text,
//                                       "address": addressController.text,
//                                     });

//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text("Update"),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),

//                       // 🗑 DELETE BUTTON
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => deleteHospital(doc.id),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_blood_network/screens/map_screen.dart';


class AdminHospitalScreen extends StatefulWidget {
  const AdminHospitalScreen({super.key});

  @override
  State<AdminHospitalScreen> createState() => _AdminHospitalScreenState();
}

class _AdminHospitalScreenState extends State<AdminHospitalScreen> {
  final phoneController = TextEditingController();

  String? hospitalName;
  String? address;
  double? latitude;
  double? longitude;

  final hospitalController = TextEditingController();
  final addressController = TextEditingController();

  bool isLoading = false;

  final CollectionReference hospitals = FirebaseFirestore.instance.collection(
    "hospitals",
  );

  // 🗺️ OPEN MAP PICKER
//   Future<void> openMapPicker() async {
//     final result = await MaterialPageRoute(
//   builder: (_) => const GoogleMapPage(
//     selectMode: true,
//   ),
// );

//     // if (result != null) {
//     //   setState(() {
//     //     hospitalName = result["name"];
//     //     address = result["address"];
//     //     latitude = result["lat"];
//     //     longitude = result["lng"];
//     //   });
//     // }
//     if (result != null) {
//       setState(() {
//         hospitalName = result["name"];
//         address = result["address"];
//         latitude = result["lat"];
//         longitude = result["lng"];

//         hospitalController.text = hospitalName ?? "";
//         addressController.text = address ?? "";
//       });
//     }
//   }
Future<void> openMapPicker() async {
    Navigator.pop(context); // Close dialog before opening map

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GoogleMapPage(selectMode: true)),
    );

    if (result != null) {
      hospitalName = result["name"];
      address = result["address"];
      latitude = result["lat"];
      longitude = result["lng"];

      hospitalController.text = hospitalName ?? "";
      addressController.text = address ?? "";

      // Reopen dialog with selected values
      showAddDialog();
    }
  }
  // 🟢 ADD HOSPITAL
 Future<void> addHospital() async {
    if (phoneController.text.isEmpty ||
        hospitalController.text.isEmpty ||
        addressController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Select hospital and enter phone");
      return;
    }

    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString("uid") ?? "";

      if (uid.isEmpty) throw Exception("Admin UID not found");

      await hospitals.add({
        "uid": uid,
        "name": hospitalController.text.trim(),
        "phone": phoneController.text.trim(),
        "address": addressController.text.trim(),
        "latitude": latitude,
        "longitude": longitude,
        "verified": false,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(msg: "Hospital Added Successfully");

      // Clear all fields
      phoneController.clear();
      hospitalController.clear();
      addressController.clear();

      hospitalName = null;
      address = null;
      latitude = null;
      longitude = null;

      setState(() {});

      // Close popup
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    setState(() => isLoading = false);
  }
  // 🗑 DELETE
  Future<void> deleteHospital(String id) async {
    await hospitals.doc(id).delete();
    Fluttertoast.showToast(msg: "Deleted");
  }

  // ✔ VERIFY
  Future<void> toggleVerify(String id, bool status) async {
    await hospitals.doc(id).update({"verified": !status});
  }

  // ➕ ADD DIALOG
  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Hospital"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Pick Location on Map"),
              // onPressed: () async {
              //   Navigator.pop(context);
              //   await openMapPicker();
              // },
              // onPressed: () async {
              //   await openMapPicker();
              // },
              onPressed: openMapPicker,
            ),


            const SizedBox(height: 10),

            // Text(hospitalName ?? "No hospital selected"),
            // Text(address ?? "No address"),


TextField(
              controller: hospitalController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Hospital Name"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: addressController,
              readOnly: true,
              maxLines: 2,
              decoration: const InputDecoration(labelText: "Hospital Address"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     await addHospital();
          //     Navigator.pop(context);
          //   },
          //   child: const Text("Save"),
          // ),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    await addHospital();
                  },
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Hospitals"),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: showAddDialog),
        ],
      ),

      body: StreamBuilder(
        stream: hospitals.orderBy("createdAt", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  title: Text(data["name"] ?? ""),
                  subtitle: Text(data["address"] ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          data["verified"] == true
                              ? Icons.verified
                              : Icons.verified_outlined,
                          color: Colors.green,
                        ),
                        onPressed: () =>
                            toggleVerify(doc.id, data["verified"] ?? false),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteHospital(doc.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
