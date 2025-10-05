import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controller/checkout/checkout_bloc.dart';
import 'shimmer_checkout_location_widget.dart';

class DefaultLoctionWidget extends StatelessWidget {
  const DefaultLoctionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Theme.of(context).colorScheme.surface),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Addreess",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            GestureDetector(
              onTap: () => context.pushNamed("savedAddress"),
              child: const Text(
                "change",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 44,
              child: state.isDefaultLocationLoading
                  ? const ShimmerCheckoutLocationWidget()
                  : !state.locationFind
                      ? Text(
                          "Not Find Any Location Please click change and add Location",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : ListTile(
                          title: Text(state.defaultLocation.addressName),
                          subtitle: Text(
                            state.defaultLocation.fullAddress,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          leading: const Icon(Icons.location_on_outlined),
                        ),
            ),
          );
        }),
        Divider(color: Theme.of(context).colorScheme.surface),
        const SizedBox(height: 10),
      ],
    );
  }
}
