import 'package:flutter/material.dart';

class TextTextButton extends StatelessWidget {
  final String text;
  final String buttonText;
  final void Function() onPressed;
  const TextTextButton({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(
        top: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
        ],
      ),
    );
  }
}
