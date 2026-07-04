// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/screens/signup_screen.dart';
// import 'package:smart_blood_network/utils/colors.dart';
// import 'package:smart_blood_network/utils/customimage.dart';
// import 'package:smart_blood_network/utils/images.dart';
// import 'package:smart_blood_network/utils/responsive.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final r = Responsive(context);

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F6F6),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ///================ HEADER ==================
//                         Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 /// Background
//                 CustomImageContainer(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   imageUrl: AppImages.rectbg,
//                 ),


//                 // SizedBox(
//                 //   height: r.hp(35),
//                 //   child: SafeArea(
//                 //     child: Column(
//                 //       children: [
//                 //         SizedBox(height: r.hp(1.5)),

//                 //         CustomImageContainer(
//                 //           height: r.hp(9),
//                 //           width: r.wp(25),
//                 //           imageUrl: AppImages.logo,
//                 //         ),

//                 //         SizedBox(height: r.hp(1.5)),

//                 //         Text(
//                 //           "Hello! Welcome Back",
//                 //           style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontWeight: FontWeight.bold,
//                 //             fontSize: r.sp(22),
//                 //           ),
//                 //         ),

//                 //         SizedBox(height: r.hp(.5)),

//                 //         Text(
//                 //           "Sign in to your Account",
//                 //           style: TextStyle(
//                 //             color: Colors.white70,
//                 //             fontSize: r.sp(14),
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),

//                 /// Header Content
//                 SizedBox(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   child: SafeArea(
//                     child: Column(
//                       children: [
//                         SizedBox(height: r.hp(1)),

//                         /// Logo
//                         CustomImageContainer(
//                           height: r.hp(12),
//                           width: r.wp(38),
//                           imageUrl: AppImages.logo,
//                         ),

//                         SizedBox(height: r.hp(2)),

//                         Text(
//                           "Welcome Back",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: r.sp(28),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         SizedBox(height: r.hp(0.5)),

//                         Text(
//                           "Login to continue",
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(.9),
//                             fontSize: r.sp(14),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 ///================ LOGIN CARD =================
//                 Positioned(
//                   bottom: -r.hp(20),
//                   left: 20,
//                   right: 20,
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 15,
//                           color: Colors.black12,
//                           offset: Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         TextField(
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             prefixIcon: Icon(Icons.phone, color: Colors.grey),
//                             hintText: "Mobile Number",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 15),

//                         TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             prefixIcon: Icon(
//                               Icons.lock_outline,
//                               color: Colors.grey,
//                             ),
//                             hintText: "Password",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 10),

//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (v) {},
//                                 activeColor: Colors.red,
//                               ),
//                             ),

//                             SizedBox(width: 8),

//                             Text("Remember me", style: TextStyle(fontSize: 13)),

//                             Spacer(),

//                             TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "Forgot password?",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         SizedBox(height: 10),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 48,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               print("Login button pressed");
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               elevation: 0,
//                             ),
//                             child: const Text(
//                               "Sign In",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: r.hp(24)),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Don't have an account?",
//                   style: TextStyle(fontSize: 13),
//                 ),

//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const SignupScreen()),
//                     );
//                   },
//                   child: const Text(
//                     "Sign Up!",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_blood_network/screens/home_screen.dart';
import 'package:smart_blood_network/screens/profile_screen.dart';
import 'package:smart_blood_network/screens/signup_screen.dart';
import 'package:smart_blood_network/utils/colors.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/customtextfields.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;


// Future<void> loginUser() async {
//     setState(() => isLoading = true);

//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       final user = credential.user;

//       if (user != null) {
//         // SAVE UID LOCALLY
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString("uid", user.uid);
//       }

//       if (!mounted) return;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Login Successful")));


//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => HomeScreen()),
//       );
//       print("User logged and UID: ${user?.uid}");
//     } on FirebaseAuthException catch (e) {
//       String message = "Login failed";

//       if (e.code == 'user-not-found') {
//         message = "No user found for this email.";
//       } else if (e.code == 'wrong-password') {
//         message = "Wrong password.";
//       }

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(message)));
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

Future<void> loginUser() async {
    setState(() => isLoading = true);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = credential.user;

      if (user == null) {
        throw FirebaseAuthException(code: "user-not-found");
      }

      // Save UID in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", user.uid);

      // Check if profile exists
      final DocumentSnapshot profileDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
          backgroundColor: Colors.green,
        ),
      );

      if (profileDoc.exists) {
        // Profile already created
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        // Profile not created
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
      }

      debugPrint("User UID : ${user.uid}");
    } on FirebaseAuthException catch (e) {
      String message = "Login Failed";

      switch (e.code) {
        case "user-not-found":
          message = "No user found with this email.";
          break;

        case "wrong-password":
          message = "Incorrect password.";
          break;

        case "invalid-email":
          message = "Invalid email address.";
          break;

        case "invalid-credential":
          message = "Invalid email or password.";
          break;

        case "too-many-requests":
          message = "Too many attempts. Please try again later.";
          break;

        default:
          message = e.message ?? "Login Failed";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER STACK
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomImageContainer(
                  height: r.hp(45),
                  width: double.infinity,
                  imageUrl: AppImages.rectbg,
                ),

                SizedBox(
                  height: r.hp(38),
                  width: double.infinity,
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: r.hp(1)),

                        CustomImageContainer(
                          height: r.hp(12),
                          width: r.wp(38),
                          imageUrl: AppImages.logo,
                        ),

                        SizedBox(height: r.hp(2)),

                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: r.sp(28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: r.hp(0.5)),

                        Text(
                          "Login to continue",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontSize: r.sp(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// LOGIN CARD
            Transform.translate(
              offset: Offset(0, -r.hp(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                   
                      CustomTextField(hintText: "Email", controller: emailController, prefixIcon: Icons.email, isPassword: false),

                      const SizedBox(height: 15),

                    
                        CustomTextField(
                        hintText: "Password",
                        controller: passwordController,
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                      ),

                      const SizedBox(height: 20),

                      /// LOGIN BUTTON (FIXED INSIDE CARD)
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// SIGNUP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Sign Up!",
                    style: TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: r.hp(5)),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/screens/give_take_blood_screen.dart';
// import 'package:smart_blood_network/screens/signup_screen.dart';
// import 'package:smart_blood_network/utils/customimage.dart';
// import 'package:smart_blood_network/utils/images.dart';
// import 'package:smart_blood_network/utils/responsive.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final r = Responsive(context);

//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             /// ================= HEADER =================
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 /// Background
//                 CustomImageContainer(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   imageUrl: AppImages.rectbg,
//                 ),

                // /// Header Content
                // SizedBox(
                //   height: r.hp(38),
                //   width: double.infinity,
                //   child: SafeArea(
                //     child: Column(
                //       children: [
                //         SizedBox(height: r.hp(1)),

                //         /// Logo
                //         CustomImageContainer(
                //           height: r.hp(12),
                //           width: r.wp(38),
                //           imageUrl: AppImages.logo,
                //         ),

                //         SizedBox(height: r.hp(2)),

                //         Text(
                //           "Welcome Back",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: r.sp(28),
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),

                //         SizedBox(height: r.hp(0.5)),

                //         Text(
                //           "Login to continue",
                //           style: TextStyle(
                //             color: Colors.white.withOpacity(.9),
                //             fontSize: r.sp(14),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

//                 /// Floating Login Card
//                 Positioned(
//                   bottom: -r.hp(24),
//                   left: r.wp(6),
//                   right: r.wp(6),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: r.wp(6),
//                       vertical: r.hp(3),
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(.08),
//                           blurRadius: 20,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),

//                     child: Column(
//                       children: [
//                         /// Email
//                         TextField(
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               Icons.email_outlined,
//                               color: Colors.red,
//                             ),
//                             hintText: "Email Address",
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: r.hp(2)),

//                         /// Password
//                         TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               Icons.lock_outline,
//                               color: Colors.red,
//                             ),
//                             suffixIcon: const Icon(
//                               Icons.visibility_off_outlined,
//                             ),
//                             hintText: "Password",
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: r.hp(1.5)),

//                         /// Forgot Password
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               "Forgot Password?",
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: r.sp(13),
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: r.hp(2)),

//                         /// Login Button
//                         SizedBox(
//                           width: double.infinity,
//                           height: r.hp(6.5),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               print("Login button pressed");
//                             },
//                             style: ElevatedButton.styleFrom(
//                               elevation: 0,
//                               backgroundColor: Colors.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: r.sp(16),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: r.hp(3)),

//                         /// Register
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have an account?",
//                               style: TextStyle(fontSize: r.sp(14)),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // FIX: was commented out before — now navigates correctly
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const SignupScreen(),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 "Register",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: r.sp(14),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             /// Space for Floating Card
//             SizedBox(height: r.hp(35)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login")),
//       body: const Center(child: Text("Login Screen")),
//     );
//   }
// }
