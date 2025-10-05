import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/translation/lang_bloc/language_bloc.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape:
          Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
      tilePadding: const EdgeInsets.all(0),
      leading: Icon(
        Icons.language,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      title: const Text("Language"),
      children: [
        InkWell(
          onTap: () {
            context
                .read<LanguageBloc>()
                .add(const ChangeLangeEvent(langCode: "ar"));
          },
          child: Row(
            children: [
              Text(
                "العربية",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 20),
              BlocSelector<LanguageBloc, LanguageState, String>(
                selector: (state) => state.langCode,
                builder: (context, langCode) {
                  return langCode == "ar"
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context
                .read<LanguageBloc>()
                .add(const ChangeLangeEvent(langCode: "en"));
          },
          child: Row(
            children: [
              Text(
                "English",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 20),
              BlocSelector<LanguageBloc, LanguageState, String>(
                selector: (state) => state.langCode,
                builder: (context, langCode) {
                  return langCode == "en"
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
