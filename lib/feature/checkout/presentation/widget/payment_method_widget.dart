import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listPaymentName = ["Card", "Cash", "Pay"];
    List<IconData> listPaymentIcon = [
      Icons.payment_outlined,
      Icons.attach_money_outlined,
      Icons.apple
    ];
    return Column(
      children: [
        Text(
          "Payment Method",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 36,
            child: BlocSelector<CheckoutBloc, CheckoutState, int>(
              selector: (state) => state.indexPayment,
              builder: (context, indexPayment) {
                return Row(
                    children: List.generate(listPaymentName.length, (i) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<CheckoutBloc>().add(
                              ChangePaymentMethodEvent(i, listPaymentName[i]),
                            );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: i == indexPayment
                                  ? Theme.of(context).colorScheme.inversePrimary
                                  : Theme.of(context).colorScheme.surface),
                          color: i == indexPayment
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              listPaymentIcon[i],
                              color: i == indexPayment
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                            ),
                            Text(
                              listPaymentName[i],
                              style: TextStyle(
                                color: i == indexPayment
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
              },
            ),
          ),
        ),
      ],
    );
  }
}
