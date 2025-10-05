import 'package:flutter/material.dart';

class ButtonSelectorWidget extends StatelessWidget {
  final void Function()? onTap;
  final bool colorSelectedContainer;
  final String text;
  final bool colorSelectedText;
  const ButtonSelectorWidget(
      {super.key,
      required this.onTap,
      required this.colorSelectedContainer,
      required this.text,
      required this.colorSelectedText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorSelectedContainer
            ? Theme.of(context).colorScheme.inversePrimary
            : Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(color: Theme.of(context).colorScheme.surface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: colorSelectedText
              ? Theme.of(context).textTheme.headlineLarge
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
