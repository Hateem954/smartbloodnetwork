// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/screens/onboarding_screen.dart';
// import 'package:smart_blood_network/utils/customimage.dart';
// import 'package:smart_blood_network/utils/images.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 3), () {
//       // Navigate to your next screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const OnboardingScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           /// Background Image
//           // Image.asset('assets/images/splash_bg.png', fit: BoxFit.cover),
//           Image.asset(AppImages.bg, fit: BoxFit.cover),

//           /// Dark overlay (optional)
//           Container(color: Colors.black.withOpacity(0.05)),

//           /// Logo
//           Center(
//             child:  CustomImageContainer(
//               height: 400,
//               width: 400,
//               imageUrl: AppImages.logo,
//               // borderRadius: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_blood_network/screens/home_screen.dart';
import 'package:smart_blood_network/screens/onboarding_screen.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("uid");

    if (!mounted) return;

    if (uid != null && uid.isNotEmpty) {
      // USER LOGGED IN
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // FIRST TIME USER
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.bg, fit: BoxFit.cover),

          Container(color: Colors.black.withOpacity(0.05)),

          Center(
            child: CustomImageContainer(
              height: 400,
              width: 400,
              imageUrl: AppImages.logo,
            ),
          ),
        ],
      ),
    );
  }
}
