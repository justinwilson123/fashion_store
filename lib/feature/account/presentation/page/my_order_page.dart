import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/account/presentation/controller/order/order_bloc.dart';
import 'package:fashion/feature/account/presentation/widget/myorder/completed_order_widget.dart';
import 'package:fashion/feature/account/presentation/widget/myorder/ongonig_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widget/myorder/selected_order_widget.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pc = PageController();
    context.read<OrderBloc>().add(const GetOrederOngoingEvent());
    context.read<OrderBloc>().add(const GetOrederCompletedEvent());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: SafeArea(
          child: Column(
            children: [
              TitlePageWidget(
                title: "My Order",
                onPressed: () => context.pop(),
              ),
              SelectedOrder(pc: pc),
              Expanded(
                child: PageView(
                  controller: pc,
                  onPageChanged: (i) {
                    context
                        .read<OrderBloc>()
                        .add(TranBetweenOngingCompletedEvent(i));
                  },
                  scrollDirection: Axis.horizontal,
                  children: [
                    OngonigOrderWidget(),
                    CompletedOrderWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
