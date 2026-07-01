import 'package:flutter/material.dart';
import 'package:smart_blood_network/screens/login_screen.dart';
import 'package:smart_blood_network/screens/splash_screen.dart';
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
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                /// Background Image
                CustomImageContainer(
                  height: r.hp(45),
                  width: double.infinity,
                  imageUrl: AppImages.rectbg,
                ),

                /// HEADER CONTENT
                SizedBox(
                  height: r.hp(45),
                  width: double.infinity,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: r.hp(1)),
                          child: CustomImageContainer(
                            height: r.hp(12),
                            width: r.wp(38),
                            imageUrl: AppImages.logo,
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        Text(
                          "How it Work!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: r.sp(26),
                          ),
                        ),

                        SizedBox(height: r.hp(0.5)),

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

                /// FLOATING CARD
                Positioned(
                  bottom: -r.hp(22),
                  left: r.wp(6),
                  right: r.wp(6),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: r.wp(5),
                      vertical: r.hp(3),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: r.hp(7),
                          width: r.wp(30),
                          child: CustomPaint(
                            painter: LoopArrowPainter(color: Colors.red),
                          ),
                        ),

                        SizedBox(height: r.hp(2)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bloodOption(
                              r: r,
                              title: "Give\nBlood",
                              isSelected: true,
                            ),
                            bloodOption(
                              r: r,
                              title: "Take\nBlood",
                              isSelected: false,
                            ),
                          ],
                        ),

                        SizedBox(height: r.hp(4)),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // FIX: don't push same screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// SPACE FOR FLOATING CARD
            SizedBox(height: r.hp(26)),
          ],
        ),
      ),
    );
  }
  Widget bloodOption({
    required Responsive r,
    required String title,
    required bool isSelected,
  }) {
    final primaryColor = Colors.red;
    final size = r.wp(32);

    return CustomPaint(
      painter: isSelected ? null : DashedCirclePainter(color: primaryColor),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xffFFEBEE),
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: primaryColor.withOpacity(0.5), width: 2)
              : null, // Custom painter handles dashed borders
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: r.sp(16),
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= CUSTOM PAINTERS FOR UI ACCURACY =================

/// Custom Painter to draw the specific looping design arrow
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

    // Starting on the left, looping up, twisting down/around, and finishing on the right arrow
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

    // Arrowhead calculations at the end of the path
    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final arrowPath = Path();
    arrowPath.moveTo(size.width * 0.82, size.height * 0.52);
    arrowPath.lineTo(size.width * 0.9, size.height * 0.67);
    arrowPath.lineTo(size.width * 0.98, size.height * 0.52);

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Painter to generate the dashed outer circle look for the unselected option
class DashedCirclePainter extends CustomPainter {
  final Color color;
  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double radius =
        size.width / 2 + 3; // Slighly outside container bounds
    final Offset center = Offset(size.width / 2, size.height / 2);

    const int dashCount = 40;
    const double dashLength = (2 * math.pi) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      if (i % 2 == 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          i * dashLength,
          dashLength,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
