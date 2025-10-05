import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controller/checkout/checkout_bloc.dart';
import 'shimmer_checkout_paymant_widget.dart';

class DefaultCardWidget extends StatelessWidget {
  const DefaultCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Theme.of(context).colorScheme.surface),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return state.isDefaultCardLoading
                ? const ShimmerCheckoutPaymantWidget()
                : Container(
                    height: 52,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: !state.paymentFind
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Not Find any card pleas click edit and add on",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.pushNamed("savedCards"),
                                child: const Icon(Icons.edit_outlined),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: SizedBox(
                                  width: 70,
                                  height: 52,
                                  child: Center(
                                    child: Text(
                                      state.defaultCard.cardBrand.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                  "  **** **** **** ${state.defaultCard.cardLast4}"),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => context.pushNamed("savedCards"),
                                child: const Icon(Icons.edit_outlined),
                              ),
                            ],
                          ),
                  );
          },
        ),
      ],
    );
  }
}
