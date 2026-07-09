// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/screens/profile_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   final List<Map<String, String>> donors = [
//     {"name": "Imran Hossen", "location": "Pakistan, Lahore", "blood": "B+"},
//     {"name": "Farjana Afrin", "location": "Pakistan, Dubai", "blood": "O+"},
//     {"name": "John Dules", "location": "Pakistan, Karachi", "blood": "B+"},
//     {
//       "name": "Judith Rodriguez",
//       "location": "Pakistan, Islamabad",
//       "blood": "A+",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF6F6F6),

//       /// ================= APP BAR =================
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         elevation: 0,
//         title: const Text("Home"),
//         leading:  Icon(Icons.menu),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Icon(Icons.notifications),
//           ),
//         ],
//       ),

//       /// ================= BODY =================
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             /// SEARCH BAR
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search by location",
//                   prefixIcon: const Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),

//             /// SORT + FILTER
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 children: [
//                   _smallButton("Sort", Icons.sort),
//                   const SizedBox(width: 10),
//                   _smallButton("Filter", Icons.filter_list),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 10),

//             /// LIST
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: donors.length,
//               itemBuilder: (context, index) {
//                 final donor = donors[index];

//                 return _donorCard(
//                   name: donor["name"]!,
//                   location: donor["location"]!,
//                   blood: donor["blood"]!,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),

//       /// ================= BOTTOM NAV =================
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });

//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ProfileScreen(),
//               ),
//             );
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Donate"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   /// SMALL BUTTON
//   Widget _smallButton(String text, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [Icon(icon, size: 18), const SizedBox(width: 5), Text(text)],
//       ),
//     );
//   }

//   /// DONOR CARD
//   Widget _donorCard({
//     required String name,
//     required String location,
//     required String blood,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(location, style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),

//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.red.shade50,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               blood,
//               style: const TextStyle(
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           const SizedBox(width: 10),
//           const Icon(Icons.phone, color: Colors.green),
//           const SizedBox(width: 8),
//           const Icon(Icons.message, color: Colors.blue),
//         ],
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_blood_network/screens/admin_hospital%20screen.dart';
import 'package:smart_blood_network/screens/all_hospital_screen.dart';
import 'package:smart_blood_network/screens/donar_detail_screen.dart';
import 'package:smart_blood_network/screens/donar_screen.dart';
import 'package:smart_blood_network/screens/emergency_req_screen.dart';
import 'package:smart_blood_network/screens/emergency_widget.dart';
import 'package:smart_blood_network/screens/hospital_detail_screen.dart';
import 'package:smart_blood_network/screens/login_screen.dart';
import 'package:smart_blood_network/screens/nearby_search_screen.dart';
import 'package:smart_blood_network/screens/pending_user_screen.dart';
import 'package:smart_blood_network/screens/profile_screen.dart';
import 'package:smart_blood_network/screens/user_profile.dart';
import 'package:smart_blood_network/screens/users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
int totalDonors = 0;
  /// 🔥 ROLE FROM FIRESTORE
  String role = "user";
  bool isLoadingRole = true;
  bool isAvailable = false;
  bool hasProfile = false;
  String userName = "User";
  String uid = "";
  String? currentUid;
  int acceptedUsers = 0;
  int pendingUsers = 0;
  int totalHospitals = 0;
  int totalRequests = 0;

  @override
  void initState() {
    super.initState();
    fetchUserRole();
    loadAvailability();
    loadDashboardStats();
    checkUserProfile();
     getTotalDonors();
     checkUserStatus();
     checkUserStatusWidget();
     loadCurrentUid();
  }


Future<void> loadCurrentUid() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      currentUid = prefs.getString("uid");
    });
  }

Future<void> checkUserStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        return;
      }

      final data = doc.data()!;
      final String status = (data["status"] ?? "pending")
          .toString()
          .toLowerCase();

      if (status == "accepted") {
      
        // User is approved
        return;
      }

      if (status == "pending") {
        if (!mounted) return;

        Icon(Icons.hourglass_top, color: Colors.orange, size: 70);
        SizedBox(height: 20);
        Text(
          "Your account is under review.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
        SizedBox(height: 10);
        Text("Please wait for admin approval.");
        return;
      }

      if (status == "rejected") {
        if (!mounted) return;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text("Account Rejected"),
            content: const Text(
              "Your account has been rejected by the administrator. Please contact support.",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  if (!mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget checkUserStatusWidget() {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("User not found"));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final status = (data["status"] ?? "pending").toString().toLowerCase();

        if (status == "accepted") {
          return _userDashboard();
        } else if (status == "pending") {
          return const Center(
            child: Text(
              "Your account is pending approval.",
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return const Center(
            child: Text(
              "Your account has been rejected.",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }
      },
    );
  }
Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

// Widget _allDonors() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection("donors").snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Text("No donors found.");
//         }

//         final donors = snapshot.data!.docs;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Text(
//                 "🩸 Available Donors",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),

//             // ...donors.map((doc) {
//             //   final donor = doc.data() as Map<String, dynamic>;

           
//             // ...donors.map((doc) {
//             //   final donor = doc.data() as Map<String, dynamic>;
//             //      return Card(
//             //       margin: const EdgeInsets.only(bottom: 8),
//             //       child: ListTile(
//             //         leading: const CircleAvatar(child: Icon(Icons.person)),

//             //         title: Text(
//             //           donor["blood_group"] ?? "",
//             //           style: const TextStyle(fontWeight: FontWeight.bold),
//             //         ),

//             //         subtitle: Text("${donor["city"]} • ${donor["availability"]}"),

//             //         trailing: const Text(
//             //           "View Details",
//             //           style: TextStyle(
//             //             color: Colors.red,
//             //             fontWeight: FontWeight.bold,
//             //           ),
//             //         ),

//             //         onTap: () {
//             //           _showDonorDetails(context, donor);
//             //         },
//             //       ),
//             //     );
//             // }).toList(),
         
//          ...donors.map((doc) {
//               final donor = doc.data() as Map<String, dynamic>;

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatar(
//                             radius: 28,
//                             backgroundColor: Colors.grey.shade200,
//                             backgroundImage:
//                                 donor["image"] != null &&
//                                     donor["image"].toString().isNotEmpty
//                                 ? NetworkImage(donor["image"])
//                                 : null,
//                             child:
//                                 donor["image"] == null ||
//                                     donor["image"].toString().isEmpty
//                                 ? const Icon(Icons.person, size: 30)
//                                 : null,
//                           ),

//                           const SizedBox(width: 12),

//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Text(
//                                 //   donor["name"] ?? "Unknown Donor",
//                                 //   style: const TextStyle(
//                                 //     fontSize: 16,
//                                 //     fontWeight: FontWeight.bold,
//                                 //   ),
//                                 // ),
//                                 FutureBuilder<QuerySnapshot>(
//                                   future: FirebaseFirestore.instance
//                                       .collection("users")
//                                       .where("uid", isEqualTo: donor["uid"])
                                      
//                                       .get(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return const Text(
//                                         "Loading...",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       );
//                                     }

//                                     if (!snapshot.hasData ||
//                                         snapshot.data!.docs.isEmpty) {
//                                       return const Text(
//                                         "Unknown Donor",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       );
//                                     }

//                                     final user =
//                                         snapshot.data!.docs.first.data()
//                                             as Map<String, dynamic>;

//                                     return Text(
//                                       user["fullName"] ?? "Unknown Donor",
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     );
//                                   },
//                                 ),

//                                 const SizedBox(height: 4),

//                                 Text(
//                                   donor["city"] ?? "",
//                                   style: TextStyle(
//                                     color: Colors.grey.shade700,
//                                     fontSize: 13,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 2),

//                                 Text(
//                                   donor["availability"] ?? "",
//                                   style: TextStyle(
//                                     color: Colors.grey.shade700,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           Column(
//                             children: [
//                               Text(
//                                 donor["blood_group"] ?? "",
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),

//                               const SizedBox(height: 12),

//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 16,
//                                     backgroundColor: Colors.red.shade50,
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       iconSize: 16,
//                                       icon: const Icon(
//                                         Icons.message,
//                                         color: Colors.red,
//                                       ),
//                                       onPressed: () {
//                                         // Chat
//                                       },
//                                     ),
//                                   ),

//                                   const SizedBox(width: 8),

//                                   CircleAvatar(
//                                     radius: 16,
//                                     backgroundColor: Colors.red.shade50,
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       iconSize: 16,
//                                       icon: const Icon(
//                                         Icons.call,
//                                         color: Colors.red,
//                                       ),
//                                       onPressed: () {
//                                         // Call
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 16),

//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 shape: const StadiumBorder(),
//                               ),
//                               onPressed: () {
//                                 _showDonorDetails(context, donor);
//                               },
//                               child: const Text("View Details"),
//                             ),
//                           ),

//                           const SizedBox(width: 10),

//                           Expanded(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                                 foregroundColor: Colors.white,
//                                 shape: const StadiumBorder(),
//                               ),
//                               onPressed: () {
//                                 // Request donor
//                               },
//                               child: const Text("Request for Donor"),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     );
//   }


//   Widget donorCard(BuildContext context, Map<String, dynamic> donor) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Column(
//         children: [
//           /// Top Row
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 28,
//                 backgroundColor: Colors.grey,
//                 child: Icon(Icons.person, color: Colors.white),
//               ),

//               const SizedBox(width: 10),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       donor["fullName"] ?? "Unknown Donor",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),

//                     const SizedBox(height: 3),

//                     Text(
//                       donor["location"] ?? "",
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     ),

//                     // Text(
//                     //   donor["city"] ?? "",
//                     //   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     // ),
//                   ],
//                 ),
//               ),
// Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     donor["blood_group"],
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircleAvatar(
//                         radius: 14,
//                         backgroundColor: Colors.red.shade50,
//                         child: const Icon(
//                           Icons.bloodtype,
//                           size: 16,
//                           color: Colors.red,
//                         ),
//                       ),

//                       const SizedBox(width: 8),

//                       CircleAvatar(
//                         radius: 14,
//                         backgroundColor: Colors.red.shade50,
//                         child: const Icon(
//                           Icons.call,
//                           size: 16,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           ),

//           const SizedBox(height: 12),

//           /// Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {
//                     _showDonorDetails(context, donor);
//                   },
//                   child: const Text("View Details"),
//                 ),
//               ),

//               const SizedBox(width: 10),

//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   onPressed: () {
//                     // Request Donation
//                   },
//                   child: const Text(
//                     "Request to Donate",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }


Widget _allDonors() {
    if (currentUid == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("donors").snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No donors found.");
        }

        final allDonors = snapshot.data!.docs;

        // Remove logged-in user's donor profile
        final donors = allDonors.where((doc) {
          final donor = doc.data() as Map<String, dynamic>;

          return donor["uid"] != currentUid;
        }).toList();

        if (donors.isEmpty) {
          return const Text("No other donors available.");
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "🩸 Available Donors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ...donors.map((doc) {
              final donor = doc.data() as Map<String, dynamic>;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Profile Image
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey.shade200,

                            backgroundImage:
                                donor["image"] != null &&
                                    donor["image"].toString().isNotEmpty
                                ? NetworkImage(donor["image"])
                                : null,

                            child:
                                donor["image"] == null ||
                                    donor["image"].toString().isEmpty
                                ? const Icon(Icons.person, size: 30)
                                : null,
                          ),

                          const SizedBox(width: 12),

                          // Name + City + Availability
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection("users")
                                      .where("uid", isEqualTo: donor["uid"])
                                      .get(),

                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text(
                                        "Loading...",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return const Text(
                                        "Unknown Donor",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }

                                    final user =
                                        snapshot.data!.docs.first.data()
                                            as Map<String, dynamic>;

                                    return Text(
                                      user["fullName"] ?? "Unknown Donor",

                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  donor["city"] ?? "",

                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                Text(
                                  donor["availability"] ?? "",

                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Blood Group + Buttons
                          Column(
                            children: [
                              Text(
                                donor["blood_group"] ?? "",

                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.red.shade50,

                                    child: IconButton(
                                      padding: EdgeInsets.zero,

                                      iconSize: 16,

                                      icon: const Icon(
                                        Icons.message,
                                        color: Colors.red,
                                      ),

                                      onPressed: () {
                                        // Chat
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.red.shade50,

                                    child: IconButton(
                                      padding: EdgeInsets.zero,

                                      iconSize: 16,

                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.red,
                                      ),

                                      onPressed: () {
                                        // Call
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                              ),

                              onPressed: () {
                                _showDonorDetails(context, donor);
                              },

                              child: const Text("View Details"),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,

                                foregroundColor: Colors.white,

                                shape: const StadiumBorder(),
                              ),

                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                // Logged-in user's UID
                                final requesterId =
                                    prefs.getString("uid") ?? "";

                                if (requesterId.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("User not logged in."),
                                    ),
                                  );
                                  return;
                                }

                                // Fetch logged-in user's details
                                final userSnapshot = await FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .where("uid", isEqualTo: requesterId)
                                    .limit(1)
                                    .get();

                                if (userSnapshot.docs.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("User details not found."),
                                    ),
                                  );
                                  return;
                                }

                                final userData =
                                    userSnapshot.docs.first.data()
                                        as Map<String, dynamic>;

                                final requesterName =
                                    userData["fullName"] ?? "";

                                // Create a request document with its ID
                                final requestRef = FirebaseFirestore.instance
                                    .collection("donation_requests")
                                    .doc();

                                await requestRef.set({
                                  "requestId": requestRef.id,

                                  // Donor Information
                                  "donorId": donor["uid"],
                                  "bloodGroup": donor["blood_group"],

                                  // Requester Information
                                  "requesterId": requesterId,
                                  "requesterName": requesterName,

                                  // Request Status
                                  "status": "pending",
                                  "createdAt": FieldValue.serverTimestamp(),
                                });

                                

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Donation request sent successfully.",
                                    ),
                                  ),
                                );
                              },

                              child: const Text("Request for Donor"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
Widget donorCard(BuildContext context, Map<String, dynamic> donor) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserData(donor["uid"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Full Name from Users collection
                    // Text(
                    //   user?["fullName"] ?? "Unknown Donor",
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 15,
                    //   ),
                    // ),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .where("uid", isEqualTo: donor["uid"])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            "Loading...",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Text(
                            "Unknown Donor",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        final user =
                            snapshot.data!.docs.first.data()
                                as Map<String, dynamic>;

                        return Text(
                          user["fullName"] ?? "Unknown Donor",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 3),

                    Text(
                      donor["location"] ?? "",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    donor["blood_group"] ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.red.shade50,
                        child: const Icon(
                          Icons.bloodtype,
                          size: 16,
                          color: Colors.red,
                        ),
                      ),

                      const SizedBox(width: 8),

                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.red.shade50,
                        child: const Icon(
                          Icons.call,
                          size: 16,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  void _showDonorDetails(BuildContext context, Map<String, dynamic> donor) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Details Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Profile Image
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: donor["image"] != null
                      ? NetworkImage(donor["image"])
                      : null,
                  child: donor["image"] == null
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : null,
                ),

                const SizedBox(height: 12),

                /// Name
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .where("uid", isEqualTo: donor["uid"])
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text(
                        "Unknown Donor",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    final user =
                        snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;

                    return Text(
                      user["fullName"] ?? "Unknown Donor",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                _detailRow("Address", donor["location"] ?? "-"),
                _detailRow("Mobile Number", donor["contact"] ?? "-"),
                _detailRow(
                  "Current Status",
                  donor["availability"] ?? "Available",
                ),

                const SizedBox(height: 25),

                /// Request Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
//                   onPressed: () async {
//   final prefs = await SharedPreferences.getInstance();


//                       // final prefs = await SharedPreferences.getInstance();
//                       // await prefs.setString("uid", user.uid);

//   final requesterId = prefs.getString("uid") ?? "";
//   final requesterName = prefs.getString("user_name") ?? "";

//   await FirebaseFirestore.instance
//       .collection("donation_requests")
//       .add({
//     "donorId": donor["uid"],
//     "donorName": donor["name"],

//     "requesterId": requesterId,
//     "requesterName": requesterName,

//     "bloodGroup": donor["blood_group"],

//     "status": "pending",

//     "createdAt": FieldValue.serverTimestamp(),
//   });

//   Navigator.pop(context);

//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(
//       content: Text("Donation request sent successfully."),
//     ),
//   );
// },
onPressed: () async {
  final prefs = await SharedPreferences.getInstance();

  // Logged-in user's UID
  final requesterId = prefs.getString("uid") ?? "";

  if (requesterId.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("User not logged in."),
      ),
    );
    return;
  }

  // Fetch logged-in user's details
  final userSnapshot = await FirebaseFirestore.instance
      .collection("users")
      .where("uid", isEqualTo: requesterId)
      .limit(1)
      .get();

  if (userSnapshot.docs.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("User details not found."),
      ),
    );
    return;
  }

  final userData =
      userSnapshot.docs.first.data() as Map<String, dynamic>;

  final requesterName = userData["fullName"] ?? "";

  // Create a request document with its ID
  final requestRef = FirebaseFirestore.instance
      .collection("donation_requests")
      .doc();

  await requestRef.set({
    "requestId": requestRef.id,

    // Donor Information
    "donorId": donor["uid"],
    "bloodGroup": donor["blood_group"],

    // Requester Information
    "requesterId": requesterId,
    "requesterName": requesterName,

    // Request Status
    "status": "pending",
    "createdAt": FieldValue.serverTimestamp(),
  });

  Navigator.pop(context);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Donation request sent successfully."),
    ),
  );
},
                    child: const Text(
                      "Request to Donates",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }


Future<void> signOutUser(BuildContext context) async {
    try {
      // Show loading (optional)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("uid");

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Navigate to Login Screen
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      if (!context.mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logout Failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

Future<void> getTotalDonors() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('donors')
        .get();

    setState(() {
      totalDonors = snapshot.docs.length;
    });
  }
Future<void> fetchUserRole() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        setState(() {
          role = "user";
          userName = "User";
          isLoadingRole = false;
        });
        return;
      }

      print("🔥 CURRENT UID: ${user.uid}");

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      print("🔥 DOC EXISTS: ${doc.exists}");
      print("🔥 DATA: ${doc.data()}");

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        final fetchedRole = (data["role"] ?? "user")
            .toString()
            .trim()
            .toLowerCase();

        final fetchedName = (data["fullName"] ?? "User").toString();

        print("🔥 ROLE FROM FIRESTORE: $fetchedRole");
        print("🔥 USER NAME: $fetchedName");

        setState(() {
          role = fetchedRole;
          userName = fetchedName;
          isLoadingRole = false;
        });
      } else {
        setState(() {
          role = "user";
          userName = "User";
          isLoadingRole = false;
        });
      }
    } catch (e) {
      print("❌ ERROR: $e");

      setState(() {
        role = "user";
        userName = "User";
        isLoadingRole = false;
      });
    }
  }
  Future<void> checkUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final DocumentSnapshot profileDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      setState(() {
        hasProfile = profileDoc.exists;
      });
    } catch (e) {
      debugPrint("Profile Check Error: $e");
    }
  }

  // ================= DASHBOARD STATS =================
Future<void> loadDashboardStats() async {
    // Accepted Users
    QuerySnapshot accepted = await FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "accepted")
        .get();

    // Pending Users
    QuerySnapshot pending = await FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "pending")
        .get();

    // Hospitals
    QuerySnapshot hospitals = await FirebaseFirestore.instance
        .collection("hospitals")
        .get();

    // Blood Requests
    QuerySnapshot requests = await FirebaseFirestore.instance
        .collection("requests")
        .get();

    setState(() {
      acceptedUsers = accepted.docs.length;
      pendingUsers = pending.docs.length;
      totalHospitals = hospitals.docs.length;
      totalRequests = requests.docs.length;
    });
  }
  // ================= USER DATA =================


  final List<String> donationHistory = [
    "Donated B+ on 12 June 2026",
    "Donated B+ on 02 March 2026",
  ];

  final List<String> savedHospitals = [
    "Jinnah Hospital, Lahore",
    "Civil Hospital, Karachi",
  ];

  // final List<String> notifications = [
  //   "New emergency near your location",
  //   "Your donation was approved",
  // ];

 

  // ================= ADMIN DATA =================
  // final List<String> users = [
  //   "Imran Hossen (Active)",
  //   "Farjana Afrin (Blocked)",
  //   "John Doe (Pending)",
  // ];



  final List<String> fakeRequests = ["Fake request reported: XYZ blood demand"];

  final List<String> reports = [
    "Spam request reported by users",
    "Hospital verification issue",
  ];

  final List<String> announcements = [
    "Blood shortage alert in Lahore",
    "Emergency blood drive this weekend",
  ];

  final Map<String, String> stats = {
    "Users": "1240",
    "Hospitals": "58",
    "Requests": "320",
    "Donations": "870",
  };


Future<void> loadAvailability() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid") ?? "";

    if (uid.isEmpty) return;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    setState(() {
      isAvailable = doc["availability"] ?? false;
    });
  }

Future<void> showLogoutDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await signOutUser(context);
            },
            child: const Text("Logout",
              style: TextStyle(
                color: Colors.red,
         
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (isLoadingRole) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

   return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffF6F6F6),
drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.red),
              // accountName:  Text("Blood Donor"),
                accountName: Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                FirebaseAuth.instance.currentUser?.email ?? "",
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.red),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("My Profile"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfile()));

                // Navigate to Settings Screen
              },
            ),

             ListTile(
              leading: const Icon(Icons.update),
              title: const Text("Update Status"),
              onTap: () {
                Navigator.pop(context);

                // Navigate to Settings Screen
              },
            ),
             
          ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text("Privacy Policy"),
              onTap: () {
                Navigator.pop(context);

                // Navigate to Settings Screen
              },
            ),

ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                Navigator.pop(context);

                // Navigate to Settings Screen
              },
            ),

ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text("Support Us"),
              onTap: () {
                Navigator.pop(context);

                // Navigate to Settings Screen
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);

                // Navigate to Settings Screen
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
               onTap: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(role == "admin" ? "Admin Panel" : "User Dashboard"),
      leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions:  [
          GestureDetector(onTap: (){
            print("notification pressed");
          }, child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.notifications),
            ),
          )
          
        ],
      ),

      // ================= BODY =================
      body: role.trim().toLowerCase() == "admin"
          ? _adminPanel()
          : checkUserStatusWidget(),

      // ================= BOTTOM NAV =================
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
// if (index == 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const DonorRegistrationScreen()),
//             );
//           }
//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const ProfileScreen()),
//             );
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Donate"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

bottomNavigationBar: BottomNavigationBar(
  currentIndex: _currentIndex,
  type: BottomNavigationBarType.fixed,

  selectedItemColor: Colors.red,
  unselectedItemColor: Colors.grey,

  showSelectedLabels: true,
  showUnselectedLabels: true,

  selectedFontSize: 12,
  unselectedFontSize: 12,

  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NearbySearchScreen(),
          ),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DonorRegistrationScreen(),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const EmergencyRequestScreen(),
          ),
        );
        break;

      case 4:
        if (!hasProfile) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );
        }
        break;
    }
  },

  items: [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Search",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Donate",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.emergency),
      label: "Emergency",
    ),
    if (!hasProfile)
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Profile",
      ),
  ],
),
   );
  }
  // =====================================================
  // 🧑 USER DASHBOARD
  // =====================================================
  Widget _userDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SwitchListTile(
          //   title: Text(isAvailable ? "Available" : "Not Available"),
          //   value: isAvailable,
          //   activeColor: Colors.red,
          //   onChanged: (val) => setState(() => isAvailable = val),
          // ),
           
          SwitchListTile(
            title: Text(
              isAvailable ? "Available" : "Not Available",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            secondary: Icon(
              Icons.bloodtype,
              color: isAvailable ? Colors.green : Colors.grey,
            ),
            activeColor: Colors.red,
            value: isAvailable,
            onChanged: (value) async {
              setState(() {
                isAvailable = value;
              });

              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .update({"availability": value});
            },
          ),
         
          // _section("Saved Hospitals", savedHospitals),
          _verifiedHospitals(),
      EmergencyWidget(),
          // _section("Donation History", _allDonors()),
          _allDonors(),
          // _section("Recent Notifications", notifications),
          // _section("Nearby Emergency Cases", nearbyEmergencies),
          
        ],
      ),
    );
  }

  // =====================================================
  // 🛠 ADMIN PANEL
  // =====================================================
  Widget _adminPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "📊 Platform Statistics",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 2,
            physics: const NeverScrollableScrollPhysics(),
            // children: stats.entries
            //     .map((e) => _statCard(e.key, e.value))
            //     .toList(),

            children: [
              _statCard("Accepted Users", acceptedUsers.toString(), () {
                print("Accepted Users tapped");
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersScreen()),
                );
              }),

              _statCard("Pending Users", pendingUsers.toString(), () {
                print("Pending Users tapped");
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PendingUsersScreen()));
              }),

              _statCard("Hospitals", totalHospitals.toString(), () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminHospitalScreen()));
              }),

              _statCard("Donors", totalRequests.toString(), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Donors can be display below",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }),
            ],
          ),

          const SizedBox(height: 15),

          _allDonors(),
          // // _section("🏥 Verify Hospitals", hospitals),
          // _section("🚨 Remove Fake Requests", fakeRequests),
          // _section("⚠️ Moderate User Reports", reports),
          // _section("📢 Emergency Announcements", announcements),

          const SizedBox(height: 10),

          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(Icons.add_alert),
          //   label: const Text("Create Announcement"),
          //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          // ),
        ],
      ),
    );
  }

  // =====================================================
  // 🔁 REUSABLE UI
  // =====================================================

  Widget _section(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...items.map((e) => _card(e)).toList(),
      ],
    );
  }

  Widget _card(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }


Widget _verifiedHospitals() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("hospitals")
          .where("verified", isEqualTo: true)
          .limit(3) // Only fetch 3 hospitals
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No verified hospitals found.");
        }

        final hospitals = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "🏥 Verified Hospitals",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AllHospitalsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            ...hospitals.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: ListTile(
                  leading: const Icon(Icons.local_hospital, color: Colors.red),

                  title: Text(
                    data["name"] ?? "Unknown Hospital",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

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
            }).toList(),
          ],
        );
      },
    );
  }
  Widget _statCard(String title, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            Text(title),
          ],
        ),
      ),
    );
  }
}


