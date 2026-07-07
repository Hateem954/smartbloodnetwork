import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_blood_network/screens/home_screen.dart';
import 'package:smart_blood_network/utils/colors.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart'; // Using your custom responsive layout tool

class PickBloodGroupScreen extends StatefulWidget {
  final String FullName;
  final String dob;
  final String gender;
  final String phone;
  final String location;

  
  const PickBloodGroupScreen({required this.FullName, required this.dob, required this.gender, required this.phone, required this.location, super.key});

  @override
  State<PickBloodGroupScreen> createState() => _PickBloodGroupScreenState();
}

class _PickBloodGroupScreenState extends State<PickBloodGroupScreen> {
  bool _isLoading = false;
  // State variables to manage active selection toggles
  String _selectedType = "A";
  String _selectedRh = "+";

  final Color _primaryRed = const Color(0xffD32F2F);
  final Color _lightPinkBg = const Color(0xffFFEBEE);






Future<void> _saveUserData() async {

  final prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString("uid") ?? "";

    if (uid.isEmpty) {
      throw Exception("UID not found");
    } 
  setState(() {
    _isLoading = true;
  });

  try {
await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "uid": uid,
        "fullName": widget.FullName,
        "dob": widget.dob,
        "gender": widget.gender,
        "phone": widget.phone,
        "availability":false,
        "status": "pending",
        "location": widget.location,
        "bloodGroup": "$_selectedType$_selectedRh",
        "role": "user",
        "createdAt": FieldValue.serverTimestamp(),
      });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration completed successfully."),
        ),
      );

      // Navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
      ),

    );
    print("Error saving user data: $e");
  }

  if (mounted) {
    setState(() {
      _isLoading = false;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER BACKGROUND AREA =================
   /// ================= HEADER =================
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomImageContainer(
                  height: r.hp(45),
                  width: double.infinity,
                  imageUrl: AppImages.rectbg,
                ),

                Positioned.fill(
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: r.hp(1)),

                        /// Top Bar
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: r.wp(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),

                              Text(
                                "Pick Your Blood Group",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: r.sp(19),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "2/2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: r.sp(16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: r.hp(1.5)),

                        /// Progress Bar
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                          child: Row(
                            children: List.generate(2, (index) {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: r.wp(1),
                                  ),
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        SizedBox(height: r.hp(4)),

                        /// Blood Illustration
                        Center(child: _buildBloodGroupIllustration(r)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /// ================= GRID PLATFORM CARD CONTAINER =================
            Transform.translate(
              offset: Offset(0, -r.hp(12)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(5)),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: r.wp(6),
                    vertical: r.hp(3.5),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// Blood Group Grid Layout (2x2 Structure)
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: r.wp(4),
                        mainAxisSpacing: r.hp(2),
                        childAspectRatio: 1.3,
                        children: [
                          _buildSelectionBox(r, "A", isBloodType: true),
                          _buildSelectionBox(r, "B", isBloodType: true),
                          _buildSelectionBox(r, "O", isBloodType: true),
                          _buildSelectionBox(r, "AB", isBloodType: true),
                        ],
                      ),

                      SizedBox(height: r.hp(3)),

                      /// Rh Factor Toggle Matrix (+ / -)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: r.wp(24),
                            height: r.hp(7),
                            child: _buildSelectionBox(
                              r,
                              "+",
                              isBloodType: false,
                            ),
                          ),
                          SizedBox(width: r.wp(4)),
                          SizedBox(
                            width: r.wp(24),
                            height: r.hp(7),
                            child: _buildSelectionBox(
                              r,
                              "-",
                              isBloodType: false,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: r.hp(4)),

                      /// Action Finish Execution Button
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: r.hp(6.5),
                      //   child: ElevatedButton(
                          
                      //       // Selected data points: _selectedType and _selectedRh
                      //       onPressed: _isLoading ? null : _saveUserData,
                        
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 0,
                      //       backgroundColor: _primaryRed,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       "Finish",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: r.sp(16),
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: double.infinity,
                        height: r.hp(6.5),
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveUserData,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.red,
                            disabledBackgroundColor: _primaryRed.withOpacity(
                              0.7,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  "Finish",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: r.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Component Builder for Selectable Option Rectangles
  Widget _buildSelectionBox(
    Responsive r,
    String value, {
    required bool isBloodType,
  }) {
    final bool isSelected = isBloodType
        ? (_selectedType == value)
        : (_selectedRh == value);

    return InkWell(
      onTap: () {
        setState(() {
          if (isBloodType) {
            _selectedType = value;
          } else {
            _selectedRh = value;
          }
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? _primaryRed : _lightPinkBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: isSelected ? Colors.white : _primaryRed,
              fontSize: r.sp(22),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Creates the custom visual overlapping blood drops shown in the header
  Widget _buildBloodGroupIllustration(Responsive r) {
    return SizedBox(
      height: r.hp(14),
      width: r.wp(35),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // White Base Main Drop (Left Layer)
          Positioned(
            left: 0,
            bottom: 0,
            child: Icon(Icons.water_drop, color: Colors.white, size: r.hp(10)),
          ),
          // Clear Darker Red Outline Floating Drop (Right Layer Overlay)
          Positioned(
            right: 0,
            top: r.hp(1),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.6),
                ],
              ).createShader(bounds),
              child: Icon(Icons.water_drop_outlined, size: r.hp(9)),
            ),
          ),
          // Plus Badge Element (+)
          Positioned(
            left: r.wp(2),
            top: r.hp(2),
            child: CircleAvatar(
              radius: r.hp(1.6),
              backgroundColor: Colors.white.withOpacity(0.3),
              child: const Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ),
          // Minus Badge Element (-)
          Positioned(
            right: r.wp(4),
            top: r.hp(1.5),
            child: CircleAvatar(
              radius: r.hp(1.6),
              backgroundColor: Colors.white.withOpacity(0.3),
              child: const Icon(Icons.remove, color: Colors.white, size: 14),
            ),
          ),
        ],
      ),
    );
  }
}
