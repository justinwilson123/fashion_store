import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategories extends StatelessWidget {
  const ShimmerCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          );
        },
        // ignore: prefer_const_constructors
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        itemCount: 10,
      ),
    );
  }
}
