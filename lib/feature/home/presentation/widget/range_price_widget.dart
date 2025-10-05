import 'package:flutter/material.dart';

class RangePriceWidget extends StatelessWidget {
  final void Function(RangeValues)? onChanged;
  final double min;
  final double max;
  final String titleStart;
  final String titleEnd;
  final RangeValues values;
  const RangePriceWidget({
    super.key,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.titleStart,
    required this.titleEnd,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Price",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              Text(
                  r"$"
                  "$titleStart",
                  style: Theme.of(context).textTheme.displaySmall),
              Text(
                  r"$"
                  "$titleEnd",
                  style: Theme.of(context).textTheme.displaySmall),
            ],
          ),
          RangeSlider(
            activeColor: Theme.of(context).colorScheme.inversePrimary,
            min: min,
            max: max,
            values: values,
            onChanged: onChanged,
            labels: RangeLabels(
              titleStart,
              titleEnd,
            ),
          ),
        ],
      ),
    );
  }
}
