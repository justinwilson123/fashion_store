import 'package:flutter/material.dart';

class TextFormFieldDetailsWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final double bottom;
  final String title;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final bool? enabled;

  const TextFormFieldDetailsWidget({
    super.key,
    required this.title,
    this.enabled,
    this.onTap,
    required this.validator,
    required this.controller,
    this.onChanged,
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
        Container(
          margin: EdgeInsets.only(top: 4, bottom: bottom),
          child: TextFormField(
            enabled: enabled,
            keyboardType: keyboardType,
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            onTap: onTap,
            scrollPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.surface),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.surface),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.red),
              ),
              prefixIcon: prefixIcon,
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      ],
    );
  }
}
