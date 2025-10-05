import 'package:flutter/material.dart';

class CheckoutButtonWidget extends StatelessWidget {
  const CheckoutButtonWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.isValid,
      required this.title,
      required this.onTap,
      r});
  final void Function()? onTap;
  final double width;
  final double height;
  final bool isValid;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isValid ? onTap : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isValid
              ? Theme.of(context).colorScheme.inversePrimary
              : Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Center(
          child: Text(
            title,
            style: isValid
                ? Theme.of(context).textTheme.headlineLarge
                : Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
