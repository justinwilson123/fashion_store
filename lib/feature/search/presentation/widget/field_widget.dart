import 'package:fashion/feature/search/presentation/controller/controller/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  SpeechToText speechToText = SpeechToText();
  late SpeechToTextProvider speechProvider;
  bool speechEnabled = false;
  @override
  void initState() {
    speechProvider = SpeechToTextProvider(speechToText);
    _initSpeech();
    super.initState();
  }

  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);

    setState(() {});
  }

  void _stopListening() async {
    await speechToText.stop();

    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      widget.controller.text = result.recognizedWords;
      context.read<SearchBloc>().add(
        GetResultSearchEvent(result.recognizedWords),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        context.read<SearchBloc>().add(GetResultSearchEvent(value));
      },
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "search for clothes...",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        prefixIcon: const Icon(Icons.search_outlined),
        prefixIconColor: Theme.of(context).colorScheme.primary,
        suffixIcon: IconButton(
          onPressed: speechToText.isNotListening
              ? _startListening
              : _stopListening,
          icon: Icon(
            speechToText.isNotListening
                ? Icons.mic
                : Icons.mic_external_on_sharp,
          ),
        ),
        suffixIconColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
