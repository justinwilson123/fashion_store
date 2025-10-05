import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final bool suffix;
  final Color color;
  final bool? enabled;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final double bottom;
  final String title;
  final Key? myKey;

  const TextFieldWidget({
    super.key,
    required this.title,
    this.enabled,
    required this.myKey,
    required this.validator,
    required this.controller,
    required this.hintText,
    required this.suffix,
    required this.color,
    this.onChanged,
    required this.obscureText,
    this.keyboardType,
    this.prefixIcon,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        Form(
          key: myKey,
          child: Container(
            margin: EdgeInsets.only(top: 4, bottom: bottom),
            child: TextFormField(
              enabled: enabled,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: onChanged,
              controller: controller,
              validator: validator,
              style: Theme.of(context).textTheme.displayMedium,
              scrollPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: color),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                suffixIcon: suffix
                    ? const Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.error_outline,
                        size: 16,
                        color: Colors.red,
                      ),
                prefixIcon: prefixIcon,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
