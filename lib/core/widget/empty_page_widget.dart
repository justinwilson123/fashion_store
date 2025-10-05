import 'package:flutter/material.dart';

class EmptyPageWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final void Function()? onPressed;
  final bool showRefreshButton;
  const EmptyPageWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.onPressed,
    this.showRefreshButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Divider(
        color: Theme.of(context).colorScheme.surface,
      ),
      Expanded(
        child: Center(
          child: SizedBox(
            height: 160,
            width: 252,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Theme.of(context).colorScheme.surface,
                ),
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  textAlign: TextAlign.center,
                  subTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ),
      if (showRefreshButton)
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.refresh),
        ),
    ]);
  }
}
