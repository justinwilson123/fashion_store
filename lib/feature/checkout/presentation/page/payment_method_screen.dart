import 'package:fashion/core/widget/empty_page_widget.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/add_card_location_button.dart';
import 'package:fashion/feature/checkout/presentation/widget/shimmer_location_and_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controller/checkout/checkout_bloc.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CheckoutBloc>().add(const GetAllCardEvent());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: SafeArea(
          child: Column(
            children: [
              TitlePageWidget(
                title: "Payment Method",
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return state.isCardsLoading && state.listCard.isEmpty
                        ? const ShimmerLocationAndCard()
                        : !state.isCardsLoading && state.listCard.isEmpty
                            ? const EmptyPageWidget(
                                icon: Icons.payment_outlined,
                                title: "Not Found Card",
                                subTitle:
                                    "You are not adding any card yet pleas press button to add your card",
                              )
                            : state.listCard.isNotEmpty
                                ? ListView.separated(
                                    itemBuilder: (context, i) {
                                      return Container(
                                        height: 76,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: RadioListTile(
                                            activeColor: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            secondary: const Icon(
                                              Icons.payment_outlined,
                                            ),
                                            title:
                                                state.listCard[i].isDefault == 1
                                                    ? Row(
                                                        children: [
                                                          Text(state.listCard[i]
                                                              .cardBrand),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .surface),
                                                            child: Text(
                                                              "Default",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : Text(state
                                                        .listCard[i].cardBrand
                                                        .toUpperCase()),
                                            subtitle: Text(
                                              "**** **** **** ${state.listCard[i].cardLast4}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                            value: state.listCard[i].id,
                                            groupValue: state.groupValueCard,
                                            onChanged: (val) {
                                              context
                                                  .read<CheckoutBloc>()
                                                  .add(ChangeCardEvent(
                                                    state.listCard[i],
                                                    val!,
                                                  ));
                                              context.pop();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, i) => const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: state.listCard.length,
                                  )
                                : Container();
                  },
                ),
              ),
              AddCardLocationButton(
                onTap: () {
                  context.pushNamed("AddCard");
                },
                text: " Add New Card",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
