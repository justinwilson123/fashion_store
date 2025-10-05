import 'package:fashion/feature/account/presentation/controller/faqs/fa_qs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {
        print(val);
        context.read<FaQsBloc>().add(GetSearchFAQsEvent(val));
      },
      decoration: InputDecoration(
        hintText: "Search for questions...",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        prefixIcon: const Icon(Icons.search_outlined),
        prefixIconColor: Theme.of(context).colorScheme.primary,
        suffixIcon: const Icon(Icons.mic_none_outlined),
        suffixIconColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
