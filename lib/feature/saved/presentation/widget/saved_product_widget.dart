import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/widget/saved_icon_button_widget.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/saved/domine/entity/saved_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedProductWidget extends StatelessWidget {
  final String url;
  final String productName;
  final String productPrice;
  final int productID;
  final SavedProductEntity savedProductEntity;
  const SavedProductWidget({
    super.key,
    required this.url,
    required this.productName,
    required this.productPrice,
    required this.productID,
    required this.savedProductEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          NameAppRoute.productDetails,
          extra: ProductEntity(
            productId: savedProductEntity.productId,
            productCategoryId: savedProductEntity.productCategoryId,
            nameEn: savedProductEntity.nameEn,
            nameAr: savedProductEntity.nameAr,
            descriptionEn: savedProductEntity.descriptionEn,
            descriptionAr: savedProductEntity.descriptionAr,
            productPrice: savedProductEntity.productPrice,
            productImage: savedProductEntity.productImage,
            productDiscount: savedProductEntity.productDiscount,
            productActive: savedProductEntity.productActive,
            favorite: 1,
            countRating: savedProductEntity.countRating,
            avgRating: savedProductEntity.avgRating,
            review: savedProductEntity.review,
          ),
          pathParameters: {"fromPage": "1"},
        );
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FancyShimmerImage(
                        errorWidget: const Center(
                          child: Icon(Icons.error_outline, color: Colors.red),
                        ),
                        shimmerBaseColor: Theme.of(context).colorScheme.surface,
                        shimmerBackColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                        imageUrl: url,
                      ),
                    ),
                    SavedIconButtonWidget(productID: productID),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(productName, style: Theme.of(context).textTheme.headlineSmall),
            Text(productPrice, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
