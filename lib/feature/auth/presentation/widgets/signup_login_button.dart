import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final bool color;
  final String text;
  final void Function()? onPressed;
  final double vertical;
  const MainButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: EdgeInsets.symmetric(vertical: vertical),
      child: MaterialButton(
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color
                ? Theme.of(context).colorScheme.inversePrimary
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}
