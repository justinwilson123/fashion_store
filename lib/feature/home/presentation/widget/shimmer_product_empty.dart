import 'package:fashion/feature/home/presentation/widget/shimmer_product.dart';
import 'package:flutter/material.dart';

class ShimmgerProductEmpty extends StatelessWidget {
  const ShimmgerProductEmpty({
    super.key,
  });

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
        return ShimmerProduct();
      },
    );
  }
}
