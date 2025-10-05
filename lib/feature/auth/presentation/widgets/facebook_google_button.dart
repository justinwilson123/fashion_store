import 'package:flutter/material.dart';

class FacebookGoogleButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final bool google;
  final String text;
  const FacebookGoogleButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.google,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 56,
        decoration: BoxDecoration(
          border: google ? Border.all() : null,
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              google
                  ? "assets/image/logos_google.png"
                  : "assets/image/logos_facebook.png",
              height: 24,
              width: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                text,
                style: TextStyle(
                  color: !google ? Colors.white : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
