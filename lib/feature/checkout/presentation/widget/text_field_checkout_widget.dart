import 'package:flutter/material.dart';

class TextFieldCheckoutWidget extends StatelessWidget {
  final Key formKey;
  final String title;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Color color;
  const TextFieldCheckoutWidget({
    super.key,
    required this.formKey,
    required this.title,
    required this.color,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
            ),
            const SizedBox(height: 5),
            TextFormField(
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
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ));
  }
}
