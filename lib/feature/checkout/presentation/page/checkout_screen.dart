import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/auth/presentation/widgets/show.dart';
import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:fashion/feature/checkout/presentation/widget/add_coupon_loading_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/add_order_loading_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/coupon_text_field_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/default_loction_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/details_total_and_fee_price_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/default_card_widget.dart';
import 'package:fashion/feature/checkout/presentation/widget/payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widget/checkout_button_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context.goNamed(NameAppRoute.cart);
          return false;
        },
        child: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showSnacBarFun(context, state.errorMessage, Colors.redAccent);
            }
            if (state.successMessage.isNotEmpty) {
              showSnacBarFun(context, state.successMessage, Colors.greenAccent);
            }
            if (state.successAddOrder.isNotEmpty) {
              _buildSeccessShowDialog(context);
            }
          },
          child: SingleChildScrollView(
            child: BlocListener<CheckoutBloc, CheckoutState>(
              listener: (context, state) {
                if (state.errorMessage.isNotEmpty) {
                  showSnacBarFun(context, state.errorMessage, Colors.redAccent);
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondaryContainer,
                padding: const EdgeInsets.all(20),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitlePageWidget(
                            title: "Checkout",
                            onPressed: () {
                              context.goNamed(NameAppRoute.cart);
                            },
                          ),
                          const DefaultLoctionWidget(),
                          const PaymentMethodWidget(),
                          BlocSelector<CheckoutBloc, CheckoutState, int>(
                            selector: (state) => state.indexPayment,
                            builder: (context, indexPayment) {
                              return indexPayment == 0
                                  ? const DefaultCardWidget()
                                  : const SizedBox();
                            },
                          ),
                          const SizedBox(height: 10),
                          Divider(color: Theme.of(context).colorScheme.surface),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const DetailsTotalAndFeePriceWidget(),
                                SizedBox(
                                  height: 52,
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      BlocSelector<CheckoutBloc, CheckoutState,
                                          bool>(
                                        selector: (state) => state.validCoupon,
                                        builder: (context, validcoupon) {
                                          return CheckoutButtonWidget(
                                            onTap: () {
                                              context
                                                  .read<CheckoutBloc>()
                                                  .add(const AddCouponEvent());
                                            },
                                            width: 84,
                                            height: 52,
                                            isValid: validcoupon,
                                            title: "Add",
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        child: CouponTextFieldWidget(),
                                      )
                                    ],
                                  ),
                                ),
                                BlocSelector<CheckoutBloc, CheckoutState, bool>(
                                  selector: (state) => state.validOrder,
                                  builder: (context, validOrder) {
                                    return CheckoutButtonWidget(
                                      width: double.infinity,
                                      height: 52,
                                      isValid: validOrder,
                                      title: "Place Order",
                                      onTap: () => context
                                          .read<CheckoutBloc>()
                                          .add(const AddOrderEvent()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const AddCouponLoadingWidget(),
                      const AddOrderLoadingWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildSeccessShowDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 70,
                    color: Colors.greenAccent,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Congratulations!",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your Order has been placed.",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      context.goNamed(NameAppRoute.cart);
                      context.pushReplacementNamed(NameAppRoute.cart);
                    },
                    child: Container(
                      height: 54,
                      width: 275,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Track Your Order",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
