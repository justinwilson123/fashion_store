import 'package:flutter/material.dart';

class AddRemoveButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData iconData;
  const AddRemoveButtonWidget({
    super.key,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.surface),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 20,
          ),
        ),
      ),
    );
  }
}
