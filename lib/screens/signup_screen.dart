
// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/utils/colors.dart';
// import 'package:smart_blood_network/utils/customimage.dart';
// import 'package:smart_blood_network/utils/images.dart';
// import 'package:smart_blood_network/utils/responsive.dart';

// class SignupScreen extends StatelessWidget {
//   const SignupScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final r = Responsive(context);

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F6F6),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//                       Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 /// Background
//                 CustomImageContainer(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   imageUrl: AppImages.rectbg,
//                 ),


//                         /// Header Content
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
//                           "Create New Account",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: r.sp(28),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         SizedBox(height: r.hp(0.5)),

//                         Text(
//                           "Signup to continue",
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(.9),
//                             fontSize: r.sp(14),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 /// Signup Card
//                 Positioned(
//                   bottom: -r.hp(31),
//                   left: 20,
//                   right: 20,
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: const [
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
//                             prefixIcon: const Icon(Icons.person),
//                             hintText: "Full Name",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 15),


//                         TextField(
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             prefixIcon: const Icon(Icons.email_outlined),
//                             hintText: "Email Address",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 15),

//                         TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             prefixIcon: const Icon(Icons.lock_outline),
//                             hintText: "Password",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 15),

//                         TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.shade100,
//                             prefixIcon: const Icon(Icons.lock_outline),
//                             hintText: "Confirm Password",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 48,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.red,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                             ),
//                             child: const Text(
//                               "Create Account",
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

//             SizedBox(height: r.hp(35)),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Already have an account?",
//                   style: TextStyle(fontSize: 13),
//                 ),

//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     "Sign In",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_blood_network/screens/login_screen.dart';
import 'package:smart_blood_network/utils/colors.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/customtextfields.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      setState(() {
        _loading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already exists.';
          break;

        case 'invalid-email':
          message = 'Invalid email address.';
          break;

        case 'weak-password':
          message = 'Password must be at least 6 characters.';
          break;

        case 'network-request-failed':
          message = 'No internet connection.';
          break;

        default:
          message = e.message ?? 'Signup failed.';
      }

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     final r = Responsive(context);

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F6F6),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 /// Background Image
//                 CustomImageContainer(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   imageUrl: AppImages.rectbg,
//                 ),

//                 /// Header
//                 SizedBox(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   child: SafeArea(
//                     child: Column(
//                       children: [
//                         SizedBox(height: r.hp(1)),

//                         CustomImageContainer(
//                           height: r.hp(12),
//                           width: r.wp(38),
//                           imageUrl: AppImages.logo,
//                         ),

//                         SizedBox(height: r.hp(2)),

//                         Text(
//                           "Create New Account",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: r.sp(28),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         SizedBox(height: r.hp(0.5)),

//                         Text(
//                           "Signup to continue",
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(.9),
//                             fontSize: r.sp(14),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 /// Signup Card
//                 Positioned(
//                   bottom: -r.hp(31),
//                   left: 20,
//                   right: 20,
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: const [
//                         BoxShadow(
//                           blurRadius: 15,
//                           color: Colors.black12,
//                           offset: Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
                    
//                         CustomTextField(hintText: "Full Name", controller: _nameController, prefixIcon: Icons.person, isPassword: false),

//                         const SizedBox(height: 15),
//  CustomTextField(hintText: "Email", controller: _emailController, prefixIcon: Icons.email, isPassword: false),
                     


//                         const SizedBox(height: 15),

//                          CustomTextField(
//                           hintText: "Password",
//                           controller: _passwordController,
//                           prefixIcon: Icons.lock_outline,
//                           isPassword: true
//                           ,
//                         ),

//                         const SizedBox(height: 15),

//                          CustomTextField(
//                           hintText: "Confirm Password",
//                           controller: _confirmPasswordController,
//                           prefixIcon: Icons.lock_outline,
//                           isPassword: true,
//                         ),
//                         const SizedBox(height: 20),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: _loading ? null : signUp,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.red,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                             ),
//                             child: _loading
//                                 ? const SizedBox(
//                                     width: 24,
//                                     height: 24,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : const Text(
//                                     "Create Account",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: r.hp(35)),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Already have an account?",
//                   style: TextStyle(fontSize: 13),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     "Sign In",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }


@override
Widget build(BuildContext context) {
  final r = Responsive(context);

  return Scaffold(
    backgroundColor: const Color(0xffF6F6F6),
    body: SingleChildScrollView(
      child: Column(
        children: [
          /// HEADER
          Stack(
            clipBehavior: Clip.none,
            children: [
              CustomImageContainer(
                height: r.hp(38),
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
                        "Create New Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: r.sp(28),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: r.hp(0.5)),

                      Text(
                        "Signup to continue",
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

          /// SIGNUP CARD (FIXED - NO POSITIONED)
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
                    CustomTextField(
                      hintText: "Full Name",
                      controller: _nameController,
                      prefixIcon: Icons.person,
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      hintText: "Email",
                      controller: _emailController,
                      prefixIcon: Icons.email,
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      hintText: "Password",
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      hintText: "Confirm Password",
                      controller: _confirmPasswordController,
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 20),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : const Text(
                                "Create Account",
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

          SizedBox(height: r.hp(5)),

          /// LOGIN LINK
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(fontSize: 13),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
}