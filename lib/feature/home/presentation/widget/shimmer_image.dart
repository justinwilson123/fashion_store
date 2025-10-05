// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';

// class ShimmerImage extends StatelessWidget {
//   final String url;
//   final int isFavoriter;
//   final String productName;
//   final String productPrice;
//   final String productId;
//   final void Function()? onPressed;
//   const ShimmerImage({
//     super.key,
//     required this.url,
//     required this.isFavoriter,
//     required this.onPressed,
//     required this.productName,
//     required this.productPrice, required this.productId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             alignment: Alignment.topRight,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: FancyShimmerImage(
//                   errorWidget: const Center(
//                     child: Icon(
//                       Icons.error_outline,
//                       color: Colors.red,
//                     ),
//                   ),
//                   shimmerBaseColor: Theme.of(context).colorScheme.surface,
//                   shimmerBackColor:
//                       Theme.of(context).colorScheme.secondaryContainer,
//                   imageUrl: url,
//                 ),
//               ),
//               Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10)),
//                   margin: EdgeInsets.all(10),
//                   alignment: Alignment.center,
//                   child: IconButton(
//                     onPressed: onPressed,
//                     icon: isFavoriter == 0
//                         ? Icon(
//                             Icons.favorite_outline,
//                             color: Colors.black,
//                           )
//                         : Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                           ),
//                   ))
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           productName,
//           style: Theme.of(context).textTheme.headlineSmall,
//         ),
//         Text(
//           productPrice,
//           style: Theme.of(context).textTheme.bodySmall,
//         ),
//         SizedBox(height: 10),
//         Text(
//           productId,
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//       ],
//     );
//   }
// }
