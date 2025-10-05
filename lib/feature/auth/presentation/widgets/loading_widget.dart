import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  const LoadingWidget({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          )
        : Container();
  }
}

// Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.white.withOpacity(0.4)),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                   color: Colors.black.withOpacity(0.1),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(5),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.white.withOpacity(0.4)),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                       color: Colors.black.withOpacity(0.1),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                     child: CircularProgressIndicator(
//                   color: Theme.of(context).colorScheme.inversePrimary,
//                 )),
//               ),
//             ),
//           )