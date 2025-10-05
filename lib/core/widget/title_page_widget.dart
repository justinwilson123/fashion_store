import 'package:flutter/material.dart';
import 'notification_icon_button.dart';

class TitlePageWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const TitlePageWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const NotificationIconButton(),
          Text(title, style: Theme.of(context).textTheme.displayLarge),
          Directionality(
            textDirection: TextDirection.ltr,
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
