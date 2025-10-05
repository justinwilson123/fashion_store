import 'dart:ui';

import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddCouponLoadingWidget extends StatelessWidget {
  const AddCouponLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CheckoutBloc, CheckoutState, bool>(
      selector: (state) => state.couponLoading,
      builder: (context, loading) {
        return loading
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/coupon.json",
                    height: 400,
                    width: 400,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
