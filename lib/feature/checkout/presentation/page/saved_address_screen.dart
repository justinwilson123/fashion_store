import 'package:fashion/core/widget/empty_page_widget.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:fashion/feature/checkout/presentation/widget/add_card_location_button.dart';
import 'package:fashion/feature/checkout/presentation/widget/shimmer_location_and_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: SafeArea(
          child: Column(
            children: [
              TitlePageWidget(
                title: "Address",
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return state.isLocationsLoading &&
                            state.listLocation.isEmpty
                        ? const ShimmerLocationAndCard()
                        : !state.isLocationsLoading &&
                                state.listLocation.isEmpty
                            ? const EmptyPageWidget(
                                icon: Icons.location_on_outlined,
                                title: "Not Found Address",
                                subTitle:
                                    "you are not add any Addrss please add address",
                              )
                            : state.listLocation.isNotEmpty
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
                                              Icons.location_on_outlined,
                                            ),
                                            title: state.listLocation[i]
                                                        .defultAddress ==
                                                    1
                                                ? Row(
                                                    children: [
                                                      Text(state.listLocation[i]
                                                          .addressName),
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
                                                : Text(state.listLocation[i]
                                                    .addressName),
                                            subtitle: Text(
                                              state.listLocation[i].fullAddress,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                            value: state
                                                .listLocation[i].locationID,
                                            groupValue:
                                                state.groupValueLocation,
                                            onChanged: (val) {
                                              context.read<CheckoutBloc>().add(
                                                    ChangeLocationEvent(val!,
                                                        state.listLocation[i]),
                                                  );
                                              context.pop();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, i) => const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: state.listLocation.length,
                                  )
                                : Container();
                  },
                ),
              ),
              AddCardLocationButton(
                onTap: () {
                  context.pushNamed("AddLocation");
                },
                text: " Add New Address",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
