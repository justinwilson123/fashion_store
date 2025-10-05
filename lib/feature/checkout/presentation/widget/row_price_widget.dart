import 'package:flutter/material.dart';

class RowPriceWidget extends StatelessWidget {
  const RowPriceWidget({
    super.key,
    required this.title,
    required this.textStyle,
    required this.price,
    required this.textStylePrice,
  });
  final String title;
  final TextStyle? textStyle;
  final String price;
  final TextStyle? textStylePrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        Text(
          price,
          style: textStylePrice,
        ),
      ],
    );
  }
}
