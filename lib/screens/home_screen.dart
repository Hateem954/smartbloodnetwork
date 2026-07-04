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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_blood_network/screens/donar_screen.dart';
import 'package:smart_blood_network/screens/login_screen.dart';
import 'package:smart_blood_network/screens/profile_screen.dart';
import 'package:smart_blood_network/screens/user_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  /// 🔥 ROLE FROM FIRESTORE
  String role = "user";
  bool isLoadingRole = true;
  bool isAvailable = false;
  bool hasProfile = false;
  String userName = "User";
  String uid = "";

  @override
  void initState() {
    super.initState();
    fetchUserRole();
    loadAvailability();
    checkUserProfile();
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

 
  /// ================= FETCH ROLE FROM FIRESTORE (FIXED) =================
  // Future<void> fetchUserRole() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;

  //     if (user == null) {
  //       setState(() {
  //         role = "user";
  //         isLoadingRole = false;
  //       });
  //       return;
  //     }

  //     print("🔥 CURRENT UID: ${user.uid}");

  //     final doc = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user.uid)
  //         .get();

  //     print("🔥 DOC EXISTS: ${doc.exists}");
  //     print("🔥 DATA: ${doc.data()}");

  //     if (doc.exists && doc.data() != null) {
  //       final fetchedRole = (doc.data()!["role"] ?? "user")
  //           .toString()
  //           .trim()
  //           .toLowerCase();

  //       print("🔥 ROLE FROM FIRESTORE: $fetchedRole");

  //       setState(() {
  //         role = fetchedRole;
  //         isLoadingRole = false;
  //       });
  //     } else {
  //       setState(() {
  //         role = "user";
  //         isLoadingRole = false;
  //       });
  //     }
  //   } catch (e) {
  //     print("❌ ERROR: $e");

  //     setState(() {
  //       role = "user";
  //       isLoadingRole = false;
  //     });
  //   }
  // }


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

  // ================= USER DATA =================
  final List<String> activeRequests = [
    "Need B+ blood in Lahore",
    "Urgent O- request in Karachi",
  ];

  final List<String> donationHistory = [
    "Donated B+ on 12 June 2026",
    "Donated B+ on 02 March 2026",
  ];

  final List<String> savedHospitals = [
    "Jinnah Hospital, Lahore",
    "Civil Hospital, Karachi",
  ];

  final List<String> notifications = [
    "New emergency near your location",
    "Your donation was approved",
  ];

  final List<String> nearbyEmergencies = [
    "Accident case - 2km away",
    "Surgery need A+ blood - 5km away",
  ];

  // ================= ADMIN DATA =================
  final List<String> users = [
    "Imran Hossen (Active)",
    "Farjana Afrin (Blocked)",
    "John Doe (Pending)",
  ];

  final List<String> hospitals = [
    "Jinnah Hospital (Pending Verification)",
    "Civil Hospital (Verified)",
  ];

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
            child: const Text("Logout"),
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications),
          ),
        ],
      ),

      // ================= BODY =================
      body: role.trim().toLowerCase() == "admin"
          ? _adminPanel()
          : _userDashboard(),

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
  selectedItemColor: Colors.red,
  unselectedItemColor: Colors.grey,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DonorRegistrationScreen(),
        ),
      );
    }

    if (!hasProfile && index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    }
  },
  items: [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Donate",
    ),

    // Show Profile only if profile doesn't exist
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
          _section("Active Requests", activeRequests),
          _section("Donation History", donationHistory),
          _section("Saved Hospitals", savedHospitals),
          _section("Recent Notifications", notifications),
          _section("Nearby Emergency Cases", nearbyEmergencies),
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
            children: stats.entries
                .map((e) => _statCard(e.key, e.value))
                .toList(),
          ),

          const SizedBox(height: 15),

          _section("👥 Manage Users", users),
          _section("🏥 Verify Hospitals", hospitals),
          _section("🚨 Remove Fake Requests", fakeRequests),
          _section("⚠️ Moderate User Reports", reports),
          _section("📢 Emergency Announcements", announcements),

          const SizedBox(height: 10),

          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_alert),
            label: const Text("Create Announcement"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
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

  Widget _statCard(String title, String value) {
    return Container(
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }
}
