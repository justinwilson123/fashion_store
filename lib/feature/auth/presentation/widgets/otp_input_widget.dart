import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpInputWidget extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const OtpInputWidget(
      {super.key,
      required this.length,
      this.onCompleted,
      this.onChanged,
      this.validator,
      required this.controller,
      this.focusNode});

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color focusedBorderColor = Theme.of(context).colorScheme.inversePrimary;
    // Color fillColor = Theme.of(context).colorScheme.surface;
    Color borderColor = Theme.of(context).colorScheme.primary;
    final defaultPinTheme = PinTheme(
        width: 64,
        height: 60,
        textStyle: Theme.of(context).textTheme.displayLarge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ));
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        autofocus: true,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        controller: _controller,
        focusNode: _focusNode,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 8),
        validator: widget.validator,
        onChanged: widget.onChanged,
        onCompleted: widget.onCompleted,
        length: widget.length,
      ),
    );
  }
}
