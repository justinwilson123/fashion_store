import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../controller/checkout/checkout_bloc.dart';

class AddOrderLoadingWidget extends StatelessWidget {
  const AddOrderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CheckoutBloc, CheckoutState, bool>(
      selector: (state) => state.addOrderLoading,
      builder: (context, loading) {
        return loading
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/checkout.json",
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
