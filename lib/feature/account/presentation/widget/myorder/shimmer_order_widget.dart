import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrderWidget extends StatelessWidget {
  const ShimmerOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 107,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
