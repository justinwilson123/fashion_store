import 'package:flutter/material.dart';

import 'shimmer_saved_product.dart';

class ShimmerSavedProductEmpty extends StatelessWidget {
  const ShimmerSavedProductEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerSavedProduct();
      },
    );
  }
}
