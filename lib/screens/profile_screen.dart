// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:smart_blood_network/utils/colors.dart';
// import 'package:smart_blood_network/utils/customtextfields.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

// final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();

//  @override
//   void initState() {
//     super.initState();

//     nameController.text = "Muhammad Ali";
//     phoneController.text = "+92 300 1234567";
//     locationController.text = "Lahore, Pakistan";
//     dobController.text = "10/05/2001";
//   }

// @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     locationController.dispose();
//     dobController.dispose();
//     super.dispose();
//   }
//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(
//       source: source,
//       imageQuality: 80,
//     );

//     if (image != null && mounted) {
//       setState(() {
//         _profileImage = File(image.path);
//       });
//     }
//   }

//   void _showImagePicker() {
//     showModalBottomSheet(
//       context: context,
//       builder: (bottomContext) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text("Camera"),
//                 onTap: () {
//                   Navigator.pop(bottomContext);
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo),
//                 title: const Text("Gallery"),
//                 onTap: () {
//                   Navigator.pop(bottomContext);
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget buildProfileImage() {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         CircleAvatar(
//           radius: 60,
//           backgroundColor: AppColors.red,
//           child: CircleAvatar(
//             radius: 57,
//             backgroundColor: Colors.grey.shade200,
//             backgroundImage: _profileImage != null
//                 ? FileImage(_profileImage!)
//                 : null,
//             child: _profileImage == null
//                 ? const Icon(Icons.person, size: 60, color: Colors.grey)
//                 : null,
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: InkWell(
//             onTap: _showImagePicker,
//             child: Container(
//               height: 38,
//               width: 38,
//               decoration: const BoxDecoration(
//                 color: AppColors.red,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 color: Colors.white,
//                 size: 18,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         elevation: 0,
//         title: const Text("My Profile", style: TextStyle(color: Colors.white)),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),

//             Center(child: buildProfileImage()),

//             const SizedBox(height: 35),

//             CustomTextField(
//               controller: nameController,
//               hintText: "Full Name",
//               prefixIcon: Icons.person,
//             ),

//             const SizedBox(height: 16),

//             CustomTextField(
//               controller: dobController,
//               hintText: "Date of Birth",
//               prefixIcon: Icons.calendar_month,
//               isDateField: true,
//               onTap: _selectDate,
//             ),

//             const SizedBox(height: 16),

//             CustomTextField(
//               controller: phoneController,
//               hintText: "Phone Number",
//               prefixIcon: Icons.phone,
//               keyboardType: TextInputType.phone,
//             ),

//             const SizedBox(height: 16),

//             CustomTextField(
//               controller: locationController,
//               hintText: "Location",
//               prefixIcon: Icons.location_on,
//             ),

//             const SizedBox(height: 35),

//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Save profile
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.red,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Next",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Future<void> _selectDate() async {
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime(2000),
//     firstDate: DateTime(1950),
//     lastDate: DateTime.now(),
//   );

//   if (pickedDate != null) {
//     setState(() {
//       dobController.text =
//           "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//     });
//   }
// }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_blood_network/screens/pick_blood_group_screen.dart';
import 'package:smart_blood_network/utils/colors.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/customtextfields.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // nameController.text = "Muhammad Ali";
    // phoneController.text = "+92 300 1234567";
    // locationController.text = "Lahore, Pakistan";
    // dobController.text = "10/05/2001";
    // genderController.text = "Male";
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null && mounted) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (bottomContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(bottomContext);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(bottomContext);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Widget buildProfileAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : null,
            child: _profileImage == null
                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: _showImagePicker,
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

 @override
Widget build(BuildContext context) {
  final r = Responsive(context);

  return Scaffold(
    backgroundColor: const Color(0xffF6F6F6),
    body: SingleChildScrollView(
      child: Column(
        children: [
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
                    "Create Your Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: r.sp(19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "1/2",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: r.sp(16),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: r.hp(2)),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
            //   child: Row(
            //     children: List.generate(
            //       2,
            //       (_) => Expanded(
            //         child: Container(
            //           margin: EdgeInsets.symmetric(horizontal: r.wp(1)),
            //           height: 3,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(2),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),


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
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.white.withOpacity(
                                            0.35,
                                          ), // Grey/inactive
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
            const SizedBox(height: 20),

            buildProfileAvatar(),
          ],
        ),
      ),
    ),
  ],
),
          /// ================= FORM CARD =================
          Transform.translate(
  offset: Offset(0, -r.hp(13)),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 15,
                      color: Colors.black12,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: "Full Name",
                      prefixIcon: Icons.person,
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      controller: dobController,
                      hintText: "Date of Birth",
                      prefixIcon: Icons.calendar_month,
                      isDateField: true,
                      onTap: _selectDate,
                    ),

                    const SizedBox(height: 15),
                        CustomTextField(
                        controller: genderController,
                        hintText: "Gender",
                        prefixIcon: Icons.person,
                      ),

                      const SizedBox(height: 15),

                    CustomTextField(
                      controller: phoneController,
                      hintText: "Phone Number",
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      controller: locationController,
                      hintText: "Location",
                      prefixIcon: Icons.location_on,
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Save profile
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PickBloodGroupScreen(
                                FullName: nameController.text,
                                dob: dobController.text,
                                gender: genderController.text,
                                phone: phoneController.text,
                                location: locationController.text,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
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
    )
  );
   
}
}