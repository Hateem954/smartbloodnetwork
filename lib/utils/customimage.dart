// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:field_service_app/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomImageContainer extends StatelessWidget {
//   final double height;
//   final double width;
//   final String imageUrl;
//   final double? borderRadius;
//   final Widget? child;

//   const CustomImageContainer({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.imageUrl,
//     this.borderRadius,
//     this.child,
//   }) : super(key: key);

//   /// Helper to check if URL is network image
//   bool isNetworkImage(String url) {
//     return url.startsWith('http') || url.startsWith('https');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double radius = (borderRadius ?? 0).r;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           height: height.h,
//           width: width.w,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(radius),
//             border: Border.all(color: AppColors.transparent, width: 1.w),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(radius),
//             child: isNetworkImage(imageUrl)
//                 ? CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) =>
//                         const Center(child: CircularProgressIndicator()),
//                     errorWidget: (context, url, error) =>
//                         const Center(child: Icon(Icons.error)),
//                   )
//                 : Image.asset(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) =>
//                         const Center(child: Icon(Icons.error)),
//                   ),
//           ),
//         ),
//         if (child != null) child!,
//       ],
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_network/utils/colors.dart';

class CustomImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;
  final double? borderRadius;
  final Widget? child;

  const CustomImageContainer({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.borderRadius,
    this.child,
  });

  bool isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final radius = (borderRadius ?? 0).r;

    Widget imageWidget = isNetworkImage(imageUrl)
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          );

    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: AppColors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: child == null
              ? imageWidget
              : Stack(fit: StackFit.expand, children: [imageWidget, child!]),
        ),
      ),
    );
  }
}
