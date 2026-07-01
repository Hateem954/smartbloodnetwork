import 'package:flutter/material.dart';
import 'package:smart_blood_network/screens/give_take_blood_screen.dart';
import 'package:smart_blood_network/screens/login_screen.dart';
import 'package:smart_blood_network/utils/customimage.dart';
import 'package:smart_blood_network/utils/images.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  

                  TextButton(
                    onPressed: () {
                   
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => GiveTakeBloodScreen())));
                  
            
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// Image
               CustomImageContainer(
                height: 250,
                width: 350,
                imageUrl: AppImages.donation,
                borderRadius: 12,
              ),
              const SizedBox(height: 40),

              /// Title
              const Text(
                "Testing",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              /// Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Dramatically unleash cutting vortals\nbefore maintainable positions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              /// Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_dot(false), _dot(true), _dot(false)],
              ),


              const Spacer(),

              /// Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


static Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.red : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}