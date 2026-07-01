import 'package:flutter/material.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            Stack(
              clipBehavior: Clip.none,
              children: [
                /// Background
                CustomImageContainer(
                  height: r.hp(38),
                  width: double.infinity,
                  imageUrl: AppImages.rectbg,
                ),

                /// Header Content
                SizedBox(
                  height: r.hp(38),
                  width: double.infinity,
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: r.hp(1)),

                        /// Logo
                        CustomImageContainer(
                          height: r.hp(12),
                          width: r.wp(38),
                          imageUrl: AppImages.logo,
                        ),

                        SizedBox(height: r.hp(2)),

                        Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: r.sp(28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: r.hp(0.5)),

                        Text(
                          "Register to continue",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontSize: r.sp(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Floating Signup Card
                Positioned(
                  bottom: -r.hp(42),
                  left: r.wp(6),
                  right: r.wp(6),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: r.wp(6),
                      vertical: r.hp(3),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        /// Full Name
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.red,
                            ),
                            hintText: "Full Name",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        /// Email
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.red,
                            ),
                            hintText: "Email Address",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        /// Phone Number
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                              color: Colors.red,
                            ),
                            hintText: "Phone Number",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        /// Password
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.red,
                            ),
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                            ),
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        /// Confirm Password
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.red,
                            ),
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                            ),
                            hintText: "Confirm Password",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(3)),

                        /// Signup Button
                        SizedBox(
                          width: double.infinity,
                          height: r.hp(6.5),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: r.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(3)),

                        /// Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: r.sp(14)),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: r.sp(14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Space for Floating Card
            SizedBox(height: r.hp(55)),
          ],
        ),
      ),
    );
  }
}
