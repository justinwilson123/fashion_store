import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/checkout/checkout_bloc.dart';

class CouponTextFieldWidget extends StatelessWidget {
  const CouponTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    return Form(
      key: myKey,
      child: TextFormField(
        controller: controller,
        onChanged: (val) {
          if (myKey.currentState!.validate()) {
            context
                .read<CheckoutBloc>()
                .add(ValidCouponFieldEvent(true, controller.text));
          } else {
            context
                .read<CheckoutBloc>()
                .add(ValidCouponFieldEvent(false, controller.text));
          }
        },
        validator: (val) {
          if (val!.length < 4) {
            return "not be less than 4 letter";
          } else if (val.length > 10) {
            return "not be more than 10 letter";
          }
          return null;
        },
        style: Theme.of(context).textTheme.displayMedium,
        scrollPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
          hintText: "Enter promo card",
          hintStyle: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
