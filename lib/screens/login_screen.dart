import 'package:flutter/material.dart';
import 'package:smart_blood_network/screens/signup_screen.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

                /// Floating Login Card
                Positioned(
                  bottom: -r.hp(24),
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
                        /// Email
                        TextField(
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

                        SizedBox(height: r.hp(1.5)),

                        /// Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: r.sp(13),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        /// Login Button
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
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: r.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: r.hp(3)),

                        /// Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: r.sp(14)),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignupScreen())));
                                print("Register button pressed");
                              },
                              child: Text(
                                "Register",
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
            SizedBox(height: r.hp(35)),
          ],
        ),
      ),
    );
  }
}


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
