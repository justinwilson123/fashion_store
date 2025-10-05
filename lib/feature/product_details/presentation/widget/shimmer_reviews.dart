import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerReviews extends StatelessWidget {
  const ShimmerReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        children: List.generate(3, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
              ),
              const SizedBox(height: 7),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
              const SizedBox(height: 7),
              Container(
                height: 10,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }),
      ),
    );
  }
}
