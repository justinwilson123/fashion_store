import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/controller/controller/cart_bloc.dart';
import 'row_price_widget.dart';

class DetailsTotalAndFeePriceWidget extends StatelessWidget {
  const DetailsTotalAndFeePriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int subTotal = CartBloc.sumItem;
    context.read<CheckoutBloc>().add(GetTotalPrice(subTotal));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        RowPriceWidget(
          title: "sub_total",
          textStyle: Theme.of(context).textTheme.headlineMedium,
          price: r"$" "$subTotal",
          textStylePrice: null,
        ),
        RowPriceWidget(
          title: "VAT (%)",
          textStyle: Theme.of(context).textTheme.headlineMedium,
          price: r"$" "0.00",
          textStylePrice: null,
        ),
        RowPriceWidget(
          title: "Shipping fee",
          textStyle: Theme.of(context).textTheme.headlineMedium,
          price: r"$" "${(subTotal * 0.013).ceil()}",
          textStylePrice: null,
        ),
        Divider(color: Theme.of(context).colorScheme.surface),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total"),
            BlocSelector<CheckoutBloc, CheckoutState, int>(
              selector: (state) => state.discount,
              builder: (context, discount) {
                return discount != 0
                    ? Row(
                        children: [
                          Text(
                            "  -$discount%  ",
                            style: const TextStyle(color: Colors.red),
                          ),
                          Text(
                              "${((subTotal * 0.013).ceil() + subTotal) - ((subTotal * discount / 100).ceil())}"),
                        ],
                      )
                    : Text(
                        "${(subTotal * 0.013).ceil() + subTotal}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
              },
            ),
          ],
          // title: "Total",
          // textStyle: null,
          // price: r"$"
          //     "${(subTotal * 0.013).ceil() + subTotal}",
          // textStylePrice: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
