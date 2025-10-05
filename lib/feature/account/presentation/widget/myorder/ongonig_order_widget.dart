import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/feature/account/presentation/controller/order/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/app_links.dart';
import '../../../../../core/function/translate_from_api.dart';
import '../../../../../core/widget/empty_page_widget.dart';
import 'shimmer_order_widget.dart';

class OngonigOrderWidget extends StatelessWidget {
  const OngonigOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return state.orderOngoinStatus == OrderOngoinStatus.loading
            ? const ShimmerOrderWidget()
            : state.orderOngoinStatus == OrderOngoinStatus.noData
                ? EmptyPageWidget(
                    icon: Icons.inventory_2_outlined,
                    title: "No Ongoing Orders!",
                    subTitle: "You don’t have any ongoing orders at this time.",
                    onPressed: () => context
                        .read<OrderBloc>()
                        .add(const GetOrederOngoingEvent()),
                  )
                : state.orderOngoinStatus == OrderOngoinStatus.loaded
                    ? RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<OrderBloc>()
                              .add(const GetOrederOngoingEvent());
                        },
                        child: ListView.builder(
                          itemCount: state.orderOngoing.length,
                          itemBuilder: (context, i) {
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
                                      borderRadius: BorderRadius.circular(7),
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
                                            "${AppLinks.productImageLink}${state.orderOngoing[i].imageName}",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _nameItemAndStatus(context, state, i),
                                        _buildSizeColorCount(state, i, context),
                                        _buildPriceAndTracking(
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
              translateFromApi(context, state.orderOngoing[i].nameEn,
                  state.orderOngoing[i].nameAr),
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
          child: Text(
            state.orderOngoing[i].statusOrder,
            style: TextStyle(fontSize: 10),
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
          "size : ${state.orderOngoing[i].sizedName}",
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
                  color: Color(int.parse(state.orderOngoing[i].hexCodeColor
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
          "piece : ${state.orderOngoing[i].countItem}",
        ),
      ],
    );
  }

  Row _buildPriceAndTracking(OrderState state, int i, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          r"$"
          "${state.orderOngoing[i].sumItems}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        GestureDetector(
          onTap: () => context.pushNamed(NameAppRoute.trackOrder,
              extra: state.orderOngoing[i]),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
            child: Text(
              "Track Order",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
