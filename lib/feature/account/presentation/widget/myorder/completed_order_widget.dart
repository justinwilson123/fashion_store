import 'dart:ui';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fashion/feature/account/domain/entities/order_entity.dart';
import 'package:fashion/feature/account/presentation/controller/order/order_bloc.dart';
import 'package:fashion/feature/account/presentation/widget/myorder/shimmer_order_widget.dart';
import 'package:fashion/feature/account/presentation/widget/myorder/text_form_filed_rewiew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constant/app_links.dart';
import '../../../../../core/function/translate_from_api.dart';
import '../../../../../core/widget/empty_page_widget.dart';
import 'shimmer_more_order.dart';

class CompletedOrderWidget extends StatelessWidget {
  CompletedOrderWidget({super.key});
  final TextEditingController _review = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return state.orderCompleted.isEmpty &&
                    state.orderCompletedStatus == OrderCompletedStatus.noData
                ? EmptyPageWidget(
                    icon: Icons.inventory_2_outlined,
                    title: "No Completed Orders!",
                    subTitle:
                        "You don’t have any completed orders at this time.",
                    onPressed: () => context
                        .read<OrderBloc>()
                        .add(const RefreshOrderCompletedEvent()),
                  )
                : state.orderCompleted.isEmpty &&
                        state.orderCompletedStatus ==
                            OrderCompletedStatus.loading
                    ? const ShimmerOrderWidget()
                    : state.orderCompleted.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<OrderBloc>()
                                  .add(const RefreshOrderCompletedEvent());
                            },
                            child: ListView.builder(
                              itemCount: !state.hasRechedMax
                                  ? state.orderCompleted.length + 1
                                  : state.orderCompleted.length,
                              itemBuilder: (context, i) {
                                if (i >= state.orderCompleted.length) {
                                  if (state.orderCompletedStatus ==
                                      OrderCompletedStatus.loading) {
                                    return const ShimmerMoreOrder();
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        context.read<OrderBloc>().add(
                                            const GetOrederCompletedEvent());
                                      },
                                      child: const SizedBox(
                                        height: 54,
                                        child: Center(
                                          child: Text("More"),
                                        ),
                                      ),
                                    );
                                  }
                                }
                                return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    height: 115,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 80,
                                        height: 97,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: FancyShimmerImage(
                                            errorWidget: const Center(
                                              child: Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              ),
                                            ),
                                            shimmerBaseColor: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            shimmerBackColor: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            imageUrl:
                                                "${AppLinks.productImageLink}${state.orderCompleted[i].imageName}",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _nameItemAndStatus(
                                                context, state, i),
                                            _buildSizeColorCount(
                                                state, i, context),
                                            _buildPriceAndReview(
                                                state, i, context),
                                          ],
                                        ),
                                      ),
                                    ]));
                              },
                            ),
                          )
                        : Container();
          },
        ),
        _buildLoadingRating()
      ],
    );
  }

  BlocSelector<OrderBloc, OrderState, bool> _buildLoadingRating() {
    return BlocSelector<OrderBloc, OrderState, bool>(
      selector: (state) => state.loadingRating,
      builder: (context, loading) {
        return loading
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/rating_stars.json",
                    height: 400,
                    width: 400,
                  ),
                ),
              )
            : Container();
      },
    );
  }

  Row _nameItemAndStatus(BuildContext context, OrderState state, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 25,
            child: Text(
              translateFromApi(context, state.orderCompleted[i].nameEn,
                  state.orderCompleted[i].nameAr),
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Text(
            "Completed",
            style: TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 3, 209, 109),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Row _buildSizeColorCount(OrderState state, int i, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "size : ${state.orderCompleted[i].sizedName}",
        ),
        const Text("color : "),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: SizedBox(
              width: 25,
              height: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  color: Color(int.parse(state.orderCompleted[i].hexCodeColor
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
        Text(
          "piece : ${state.orderCompleted[i].countItem}",
        ),
      ],
    );
  }

  Row _buildPriceAndReview(OrderState state, int i, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          r"$"
          "${state.orderCompleted[i].sumItems}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        state.orderCompleted[i].isRating == 0
            ? GestureDetector(
                onTap: () => _showRating(context, state.orderCompleted[i]),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Text(
                    "Leave Review",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  const Icon(Icons.star,
                      size: 16, color: Color.fromARGB(255, 241, 217, 0)),
                  Text("${state.orderCompleted[i].rating}/5"),
                ],
              ),
      ],
    );
  }

  PersistentBottomSheetController _showRating(
      BuildContext context, OrderEntity order) {
    return showBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Leave a Review",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: Theme.of(context).colorScheme.surface),
                const SizedBox(height: 10),
                Text(
                  "How was your order?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "pleas give your rating and also your review",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 10),
                BlocSelector<OrderBloc, OrderState, int>(
                  selector: (state) => state.indexStar,
                  builder: (context, indexStar) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) {
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<OrderBloc>()
                                  .add(ChangeStarRatingEvent(index));
                            },
                            icon: Icon(
                              Icons.star,
                              color: indexStar >= index
                                  ? const Color.fromARGB(255, 241, 217, 0)
                                  : Colors.grey,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormFiledRewiew(
                  color: Theme.of(context).colorScheme.surface,
                  controller: _review,
                  hintText: "write your review",
                  validator: (val) {
                    return "";
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.read<OrderBloc>().add(RatingOrderEvent(
                          order.productID,
                          _review.text,
                          order.orderID,
                          order.colorID,
                          order.sizeID,
                        ));
                  },
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: Center(
                      child: Text(
                        "submit",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
