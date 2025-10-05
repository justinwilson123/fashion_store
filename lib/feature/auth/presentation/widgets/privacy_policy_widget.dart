import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Text(
              "32".tr(context),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(
            flex: 5,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  textAlign: TextAlign.end,
                  "33".tr(context),
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
          ),
        ],
      ),
    );
  }
}
