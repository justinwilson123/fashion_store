// import 'package:flutter/widgets.dart';

// class GridWidget extends StatelessWidget {
//   final Widget widget;
//   final Widget widget2;
//   final ScrollController? controller;
//   final int? itemCount;
//   final int indexBigerState;
//   const GridWidget({
//     super.key,
//     required this.widget,
//     required this.widget2,
//     this.controller,
//     required this.itemCount,
//     required this.indexBigerState,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       controller: controller,
//       itemCount: itemCount,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//         childAspectRatio: 0.7,
//       ),
//       itemBuilder: (context, index) {
//         if (index >= indexBigerState) {
//           return widget2;
//         }
//         return widget;
//       },
//     );
//   }
// }
