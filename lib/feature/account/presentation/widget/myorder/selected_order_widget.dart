import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/order/order_bloc.dart';

class SelectedOrder extends StatelessWidget {
  const SelectedOrder({
    super.key,
    required this.pc,
  });

  final PageController pc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      height: 54,
      child: BlocSelector<OrderBloc, OrderState, int>(
        selector: (state) => state.initIndex,
        builder: (context, i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => pc.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                  child: Container(
                    decoration: BoxDecoration(
                      color: i == 0
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : null,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(child: Text("Ongoing")),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => pc.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                  child: Container(
                    decoration: BoxDecoration(
                      color: i == 1
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : null,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(child: Text("Completed")),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
