import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMoreOrder extends StatelessWidget {
  const ShimmerMoreOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 107,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
