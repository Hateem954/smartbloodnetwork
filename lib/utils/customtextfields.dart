// import 'package:flutter/material.dart';
// import 'package:smart_blood_network/utils/colors.dart'; // Update this path to match your project

// /// A reusable custom text field widget
// Widget buildCustomTextField(
//   String label,
//   TextEditingController controller, {
//   bool obscure = false,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8),
//     child: TextField(
//       controller: controller,
//       obscureText: obscure,
//       decoration: InputDecoration(
//         hintText: label, // Display label as placeholder
//         hintStyle: const TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.w500,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12), // Rounded edges
//           borderSide: BorderSide.none, // Removes border line
//         ),
//         filled: true,
//         fillColor: AppColors.greytextfields, // Light subtle background color
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//       ),
//       style: const TextStyle(fontSize: 16, color: Colors.black),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:smart_blood_network/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool isDateField;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final bool enabled;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.isDateField = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: obscure,
        readOnly: widget.isDateField,
        enabled: widget.enabled,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        onTap: widget.onTap,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: AppColors.greytextfields,

          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.grey.shade700)
              : null,

          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                )
              : widget.isDateField
              ? Icon(Icons.calendar_month, color: Colors.grey.shade700)
              : null,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
