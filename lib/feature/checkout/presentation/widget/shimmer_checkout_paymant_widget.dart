import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCheckoutPaymantWidget extends StatelessWidget {
  const ShimmerCheckoutPaymantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.surface, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
