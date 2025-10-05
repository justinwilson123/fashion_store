import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/widget/saved_icon_button_widget.dart';

class ProductWidget extends StatelessWidget {
  final String url;
  final String productName;
  final String productPrice;
  final int productID;
  final void Function()? onTap;
  const ProductWidget({
    super.key,
    required this.url,
    required this.productName,
    required this.productPrice,
    required this.onTap,
    required this.productID,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FancyShimmerImage(
                    errorWidget: const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                    ),
                    shimmerBaseColor: Theme.of(context).colorScheme.surface,
                    shimmerBackColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    imageUrl: url,
                  ),
                ),
                SavedIconButtonWidget(
                  productID: productID,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 25,
            child: Text(
              overflow: TextOverflow.ellipsis,
              productName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            productPrice,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
