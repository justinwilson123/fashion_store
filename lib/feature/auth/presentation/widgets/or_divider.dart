import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Divider(
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
                height: 30,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text("23".tr(context)),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Divider(
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
