// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/screens/login_screen.dart';
// import 'package:smart_blood_network/screens/splash_screen.dart';
// import 'package:smart_blood_network/utils/colors.dart';
// import 'package:smart_blood_network/utils/customimage.dart';
// import 'package:smart_blood_network/utils/images.dart';
// import 'package:smart_blood_network/utils/responsive.dart';
// import 'dart:math' as math;

// class GiveTakeBloodScreen extends StatelessWidget {
//   const GiveTakeBloodScreen({super.key});

//  @override
//   Widget build(BuildContext context) {
//     final r = Responsive(context);

//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
     
//                        Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 /// Background
//                 CustomImageContainer(
//                   height: r.hp(38),
//                   width: double.infinity,
//                   imageUrl: AppImages.rectbg,
//                 ),


//                          /// Header Content
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
//                           "How it Works!",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: r.sp(28),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         SizedBox(height: r.hp(0.5)),

//                         Text(
//                           "You Give and You Take",
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(.9),
//                             fontSize: r.sp(14),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 Positioned(
//                   bottom: -r.hp(17),
//                   left: 18,
//                   right: 18,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 18,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 15,
//                           offset: Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 45,
//                           width: 120,
//                           child: CustomPaint(
//                             painter: LoopArrowPainter(color: Colors.red),
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             bloodOption(
//                               r: r,
//                               title: "Give\nBlood",
//                               isSelected: true,
//                             ),

//                             bloodOption(
//                               r: r,
//                               title: "Take\nBlood",
//                               isSelected: false,
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 22),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 42,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const LoginScreen(),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(22),
//                               ),
//                             ),
//                             child: const Text(
//                               "Next",
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

//             /// SPACE FOR FLOATING CARD
//        SizedBox(height: r.hp(20)),
//           ],
//         ),
//       ),
//     );
//   }

// Widget bloodOption({
//   required Responsive r,
//   required String title,
//   required bool isSelected,
// }) {
//   const Color primary = AppColors.red; // Use the primary color from AppColors

//   return SizedBox(
//     width: 90,
//     child: Column(
//       children: [

//         CustomPaint(
//           painter: isSelected
//               ? null
//               : DashedCirclePainter(color: primary),
//           child: Container(
//             height: 72,
//             width: 72,
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? primary
//                   : Colors.white,
//               shape: BoxShape.circle,
//               border: isSelected
//                   ? Border.all(
//                       color: Colors.red.shade200,
//                       width: 2,
//                     )
//                   : Border.all(
//                       color: Colors.red.shade100,
//                       width: 1,
//                     ),
//             ),
//             child: Center(
//               child: Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: isSelected
//                       ? Colors.white
//                       : primary,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }
// /// ================= CUSTOM PAINTERS FOR UI ACCURACY =================

// /// Custom Painter to draw the specific looping design arrow
// class LoopArrowPainter extends CustomPainter {
//   final Color color;
//   LoopArrowPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.5
//       ..strokeCap = StrokeCap.round;

//     final path = Path();

//     // Starting on the left, looping up, twisting down/around, and finishing on the right arrow
//     path.moveTo(size.width * 0.1, size.height * 0.7);
//     path.cubicTo(
//       size.width * 0.05,
//       size.height * 0.1,
//       size.width * 0.45,
//       size.height * 0.05,
//       size.width * 0.5,
//       size.height * 0.5,
//     );
//     path.cubicTo(
//       size.width * 0.55,
//       size.height * 0.95,
//       size.width * 0.35,
//       size.height * 0.95,
//       size.width * 0.45,
//       size.height * 0.4,
//     );
//     path.cubicTo(
//       size.width * 0.52,
//       size.height * 0.05,
//       size.width * 0.90,
//       size.height * 0.1,
//       size.width * 0.9,
//       size.height * 0.65,
//     );

//     canvas.drawPath(path, paint);

//     // Arrowhead calculations at the end of the path
//     final arrowPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.5
//       ..strokeCap = StrokeCap.round;

//     final arrowPath = Path();
//     arrowPath.moveTo(size.width * 0.82, size.height * 0.52);
//     arrowPath.lineTo(size.width * 0.9, size.height * 0.67);
//     arrowPath.lineTo(size.width * 0.98, size.height * 0.52);

//     canvas.drawPath(arrowPath, arrowPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// /// Custom Painter to generate the dashed outer circle look for the unselected option
// class DashedCirclePainter extends CustomPainter {
//   final Color color;
//   DashedCirclePainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;

//     final double radius =
//         size.width / 2 + 3; // Slighly outside container bounds
//     final Offset center = Offset(size.width / 2, size.height / 2);

//     const int dashCount = 40;
//     const double dashLength = (2 * math.pi) / dashCount;

//     for (int i = 0; i < dashCount; i++) {
//       if (i % 2 == 0) {
//         canvas.drawArc(
//           Rect.fromCircle(center: center, radius: radius),
//           i * dashLength,
//           dashLength,
//           false,
//           paint,
//         );
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:smart_blood_network/screens/login_screen.dart';
import 'package:smart_blood_network/utils/colors.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/images.dart';
import 'package:smart_blood_network/utils/responsive.dart';
import 'dart:math' as math;

class GiveTakeBloodScreen extends StatelessWidget {
  const GiveTakeBloodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: 
       Column(
          children: [
            SizedBox(
              height: r.hp(58), // enough space for header + floating card
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// Background
                  CustomImageContainer(
                    height: r.hp(38),
                    width: double.infinity,
                    imageUrl: AppImages.rectbg,
                  ),

                  /// Header
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
                            "How it Works!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: r.sp(28),
                            ),
                          ),

                          SizedBox(height: r.hp(.5)),

                          Text(
                            "You Give and You Take",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: r.sp(14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Floating Card
                  Positioned(
                    left: 18,
                    right: 18,
                    top: r.hp(26), // Use top instead of negative bottom
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomImageContainer(
                            imageUrl: AppImages.looparrow,
                            height: 69,
                            width: 120,
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _bloodButton(
                                title: "Give\nBlood",
                                selected: true,
                              ),
                              _bloodButton(
                                title: "Take\nBlood",
                                selected: false,
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
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
                ],
              ),
            ),
          ],
        )
      ),
    );
  }


Widget _bloodButton({required String title, required bool selected}) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.red : Colors.white,
        border: Border.all(color: Colors.red.shade200, width: 1.5),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// ================= LOOP ARROW =================

class LoopArrowPainter extends CustomPainter {
  final Color color;
  LoopArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path.moveTo(size.width * 0.1, size.height * 0.7);
    path.cubicTo(
      size.width * 0.05,
      size.height * 0.1,
      size.width * 0.45,
      size.height * 0.05,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.cubicTo(
      size.width * 0.55,
      size.height * 0.95,
      size.width * 0.35,
      size.height * 0.95,
      size.width * 0.45,
      size.height * 0.4,
    );
    path.cubicTo(
      size.width * 0.52,
      size.height * 0.05,
      size.width * 0.90,
      size.height * 0.1,
      size.width * 0.9,
      size.height * 0.65,
    );

    canvas.drawPath(path, paint);

    final arrowPath = Path();
    arrowPath.moveTo(size.width * 0.82, size.height * 0.52);
    arrowPath.lineTo(size.width * 0.9, size.height * 0.67);
    arrowPath.lineTo(size.width * 0.98, size.height * 0.52);

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ================= DASHED CIRCLE =================

class DashedCirclePainter extends CustomPainter {
  final Color color;
  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final radius = size.width / 2 + 3;
    final center = Offset(size.width / 2, size.height / 2);

    const dashCount = 40;
    const dashAngle = (2 * math.pi) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      if (i % 2 == 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          i * dashAngle,
          dashAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
