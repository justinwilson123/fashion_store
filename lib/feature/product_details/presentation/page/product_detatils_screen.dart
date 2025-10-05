import 'dart:ui';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/product_details/presentation/controller/controller/product_details_bloc.dart';
import 'package:fashion/feature/saved/presentation/controller/controller/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/function/translate_from_api.dart';
import '../../../../core/widget/saved_icon_button_widget.dart';
import '../../../auth/presentation/widgets/show_sncak_bar_widget.dart';

class ProductDetatilsScreen extends StatelessWidget {
  final ProductEntity productEntiti;
  final int fromPage;
  // final int productID
  const ProductDetatilsScreen({
    super.key,
    required this.productEntiti,
    required this.fromPage,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailsBloc>().add(
      GetSizesProductEvent(productEntiti.productId),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: WillPopScope(
        onWillPop: () async {
          fromPage == 0
              ? context.goNamed(NameAppRoute.home)
              : fromPage == 1
              ? context.goNamed(NameAppRoute.saved)
              : context.goNamed(NameAppRoute.search);
          return false;
        },
        child: BlocListener<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showSnacBarFun(context, state.errorMessage, Colors.redAccent);
            }
            if (state.successMessage.isNotEmpty) {
              showSnacBarFun(context, state.successMessage, Colors.greenAccent);
            }
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                      ),
                      child: ListView(
                        children: [
                          TitlePageWidget(
                            title: "Details",
                            onPressed: () {
                              fromPage == 0
                                  ? context.goNamed(NameAppRoute.home)
                                  : fromPage == 1
                                  ? context.goNamed(NameAppRoute.saved)
                                  : context.goNamed(NameAppRoute.search);
                            },
                          ),
                          _productImageAndfavorit(context),
                          _productNameAndDescription(context),
                          _buildChooseSize(context),
                          _buildChooseColor(context),
                        ],
                      ),
                    ),
                  ),
                  _priceAndAddToCartButton(context),
                ],
              ),
              _builCartLoading(),
            ],
          ),
        ),
      ),
    );
  }

  BlocSelector<ProductDetailsBloc, ProductDetailsState, bool>
  _builCartLoading() {
    return BlocSelector<ProductDetailsBloc, ProductDetailsState, bool>(
      selector: (state) => state.cartLoading,
      builder: (context, cartLoading) {
        return cartLoading
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/cartlottie.json",
                    height: 400,
                    width: 400,
                  ),
                ),
              )
            : Container();
      },
    );
  }

  Container _priceAndAddToCartButton(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: BorderDirectional(
          top: BorderSide(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "price",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  productEntiti.productPrice,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: (state.isSelectColor && state.isSelectSize)
                        ? () {
                            context.read<ProductDetailsBloc>().add(
                              AddToCartEvent(
                                producID: productEntiti.productId,
                                price: productEntiti.productPrice,
                                image: productEntiti.productImage,
                                nameEn: productEntiti.nameEn,
                                nameAr: productEntiti.nameAr,
                                sizeID: state.sizeID,
                                colorID: state.colorID,
                              ),
                            );
                          }
                        : null,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: state.isSelectColor && state.isSelectSize
                            ? Theme.of(context).colorScheme.inversePrimary
                            : Theme.of(context).colorScheme.secondaryContainer,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart",
                          style: state.isSelectColor && state.isSelectSize
                              ? Theme.of(context).textTheme.headlineLarge
                              : Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildChooseColor(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Choose color",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            "Color enable",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: 47,
            child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                return state.colors.isEmpty
                    ? Text(
                        "Choose Size first",
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, i) => const SizedBox(width: 7),
                        itemCount: state.colors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ProductDetailsBloc>().add(
                                ChooseColorProductEvent(
                                  state.colors[index].colorID,
                                  index,
                                ),
                              );
                            },
                            child: Card(
                              color: state.selectColor == index
                                  ? Theme.of(context).colorScheme.inversePrimary
                                  : Theme.of(
                                      context,
                                    ).colorScheme.secondaryContainer,
                              child: SizedBox(
                                width: 47,
                                child: Card(
                                  color: Color(
                                    int.parse(
                                      state.colors[index].hexCodeColor
                                          .replaceAll('#', '0xFF'),
                                    ),
                                  ),
                                  child: const Center(
                                    child: SizedBox(height: 37),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildChooseSize(BuildContext context) {
    return SizedBox(
      height: 84,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Choose Size", style: Theme.of(context).textTheme.displayMedium),
          SizedBox(
            height: 47,
            child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                return state.sizes.isEmpty
                    ? const SizedBox()
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, i) => const SizedBox(width: 7),
                        itemCount: state.sizes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ProductDetailsBloc>().add(
                                GetColorsProductEvent(
                                  index,
                                  productEntiti.productId,
                                  state.sizes[index].sizeID,
                                ),
                              );
                            },
                            child: Card(
                              color: state.selectSized == index
                                  ? Theme.of(context).colorScheme.inversePrimary
                                  : Theme.of(
                                      context,
                                    ).colorScheme.secondaryContainer,
                              child: SizedBox(
                                width: 47,
                                child: Center(
                                  child: Text(
                                    state.sizes[index].sizeName,
                                    style: state.selectSized == index
                                        ? Theme.of(
                                            context,
                                          ).textTheme.headlineLarge
                                        : Theme.of(
                                            context,
                                          ).textTheme.displayMedium,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stack _productImageAndfavorit(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FancyShimmerImage(
            height: 368,
            width: double.infinity,
            errorWidget: const Center(
              child: Icon(Icons.error_outline, color: Colors.red),
            ),
            shimmerBaseColor: Theme.of(context).colorScheme.surface,
            shimmerBackColor: Theme.of(context).colorScheme.secondaryContainer,
            imageUrl:
                "${AppLinks.productImageLink}/${productEntiti.productImage}",
          ),
        ),
        BlocListener<SavedBloc, SavedState>(
          listener: (context, state) {
            if (state.successMessage.isNotEmpty) {
              showSnacBarFun(context, state.successMessage, Colors.greenAccent);
            }
            if (state.errorMessage.isNotEmpty) {
              showSnacBarFun(context, state.errorMessage, Colors.redAccent);
            }
          },
          child: SavedIconButtonWidget(productID: productEntiti.productId),
        ),
      ],
    );
  }

  Container _productNameAndDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 133,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translateFromApi(
              context,
              productEntiti.nameEn,
              productEntiti.nameAr,
            ),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          GestureDetector(
            onTap: () {
              context.pushNamed(
                "reviews",
                extra: productEntiti,
                pathParameters: {"fromPage": fromPage.toString()},
              );
            },
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                Text("${productEntiti.avgRating}/"),
                const Text("5"),
                const SizedBox(width: 10),
                Text(
                  "(${productEntiti.review} Review)",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Text(
            translateFromApi(
              context,
              productEntiti.descriptionEn,
              productEntiti.descriptionAr,
            ),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
