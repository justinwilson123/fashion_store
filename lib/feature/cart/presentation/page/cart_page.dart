import 'dart:ui';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/function/translate_from_api.dart';
import 'package:fashion/core/widget/empty_page_widget.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/auth/presentation/widgets/show.dart';
import 'package:fashion/feature/cart/presentation/controller/controller/cart_bloc.dart';
import 'package:fashion/feature/cart/presentation/widget/add_remove_button_widget.dart';
import 'package:fashion/feature/cart/presentation/widget/shimmer_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/name_app_route.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(const GetCartEvent());
    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitlePageWidget(
                  title: "cart",
                  onPressed: () => context.goNamed(NameAppRoute.home),
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.cart.isEmpty && state.cartLoading
                        ? const Expanded(child: ShimmerCartWidget())
                        : state.cart.isEmpty && !state.cartLoading
                            ? Expanded(
                                child: EmptyPageWidget(
                                  icon: Icons.shopping_cart_outlined,
                                  title: "Your Cart Is Empty!",
                                  subTitle:
                                      "When you add products, they’ll appear here.",
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(const GetCartEvent());
                                  },
                                ),
                              )
                            : state.cart.isNotEmpty
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        _buildListViewCart(state, context),
                                        _builSubTotal(state, context),
                                        _buildVAT(state, context),
                                        _buildShippingFee(state, context),
                                        Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                        _buildTotal(state, context),
                                        const SizedBox(height: 20),
                                        _builCheckoutButton(context)
                                      ],
                                    ),
                                  )
                                : Container();
                  },
                ),
              ],
            ),
          ),
          _buildIsAddRemoveDeleteLoading(),
        ],
      ),
    );
  }

  BlocSelector<CartBloc, CartState, bool> _buildIsAddRemoveDeleteLoading() {
    return BlocSelector<CartBloc, CartState, bool>(
      selector: (state) => state.isAddRemoveDeleteLoading,
      builder: (context, isAddRemoveDeleteLoading) {
        return isAddRemoveDeleteLoading
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
            : const SizedBox();
      },
    );
  }

  BlocSelector<CartBloc, CartState, int> _builCheckoutButton(
      BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) => state.sumAllItemPrice,
      builder: (context, sumAllItemPrice) {
        return GestureDetector(
          onTap: () => sumAllItemPrice == 0
              ? showSnacBarFun(context,
                  "plase Add product not should be price 0", Colors.redAccent)
              : context.pushNamed("checkout"),
          child: Container(
            // alignment: Alignment.topCenter,
            height: 54,
            width: 341,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: const Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Go to Checkout",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 20,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding _buildTotal(CartState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total'),
          Text(
            r"$"
            "${(state.sumAllItemPrice * 0.013).ceil() + state.sumAllItemPrice}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Padding _buildShippingFee(CartState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Shipping fee',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(r"$" "${(state.sumAllItemPrice * 0.013).ceil()}"),
        ],
      ),
    );
  }

  Padding _buildVAT(CartState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'VAT (%)',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(r"$" "0.00")
        ],
      ),
    );
  }

  Padding _builSubTotal(CartState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'sub_total',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(r"$" "${state.sumAllItemPrice}"),
        ],
      ),
    );
  }

  Expanded _buildListViewCart(CartState state, BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<CartBloc>().add(const GetCartEvent());
        },
        child: ListView.builder(
          itemCount: state.cart.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              height: 115,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.surface),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 97,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
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
                        imageUrl:
                            "${AppLinks.productImageLink}${state.cart[i].imageName}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 25,
                                child: Text(
                                  translateFromApi(
                                      context,
                                      state.cart[i].nameEn,
                                      state.cart[i].nameAr),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  _buildShowDeleteDialog(context, state, i);
                                },
                                child: const Icon(
                                  size: 20,
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "size : ${state.cart[i].sizeName}",
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text("color : "),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: Container(
                                      color: Color(int.parse(state
                                          .cart[i].hexCodeColor
                                          .replaceAll('#', '0xFF'))),
                                      child: const Center(
                                          child: SizedBox(
                                        height: 22,
                                        width: 22,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              r"$"
                              "${state.cart[i].sumPriceItem}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Row(
                              children: [
                                AddRemoveButtonWidget(
                                  onTap: () {
                                    context
                                        .read<CartBloc>()
                                        .add(RemoveOnePieceEvent(
                                          state.cart[i].productID,
                                          state.cart[i].sizeID,
                                          state.cart[i].colorID,
                                        ));
                                  },
                                  iconData: Icons.remove,
                                ),
                                SizedBox(
                                  width: 25,
                                  child: Center(
                                      child:
                                          Text("${state.cart[i].countItem}")),
                                ),
                                AddRemoveButtonWidget(
                                  onTap: () {
                                    context
                                        .read<CartBloc>()
                                        .add(AddOnePieceEvent(
                                          state.cart[i].productID,
                                          state.cart[i].sizeID,
                                          state.cart[i].colorID,
                                          state.cart[i].imageName,
                                          state.cart[i].nameAr,
                                          state.cart[i].nameEn,
                                          state.cart[i].productPrice,
                                        ));
                                  },
                                  iconData: Icons.add,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> _buildShowDeleteDialog(
      BuildContext context, CartState state, int i) {
    return showDialog(
        context: context,
        builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Alert",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                  const Text(
                    "do you want delete this product ?",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("cancel"),
                        ),
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                          context.read<CartBloc>().add(DeleteAllPieceEvent(
                                state.cart[i].productID,
                                state.cart[i].sizeID,
                                state.cart[i].colorID,
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Ok",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
