import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLocationAndCard extends StatelessWidget {
  const ShimmerLocationAndCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      child: ListView.separated(
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 75,
          );
        },
        separatorBuilder: (_, i) => const SizedBox(
          height: 10,
        ),
        itemCount: 5,
      ),
    );
  }
}
