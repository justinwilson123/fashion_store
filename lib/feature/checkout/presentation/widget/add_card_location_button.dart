import 'package:flutter/material.dart';

class AddCardLocationButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const AddCardLocationButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          border: Border.all(color: Theme.of(context).colorScheme.surface),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Icon(Icons.add), Text(text)],
        ),
      ),
    );
  }
}
