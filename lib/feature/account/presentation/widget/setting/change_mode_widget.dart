import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/bloc/theme_bloc.dart';

class ChangeModeWidget extends StatelessWidget {
  const ChangeModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape:
          Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
      tilePadding: const EdgeInsets.all(0),
      leading: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ChangeThemeState) {
            return state.themeName == "dark"
                ? const Icon(Icons.dark_mode)
                : const Icon(
                    Icons.light_mode,
                    color: Colors.yellow,
                  );
          } else {
            return Container();
          }
        },
      ),
      title: const Text("Mode"),
      children: [
        InkWell(
          onTap: () {
            context.read<ThemeBloc>().add(const ChangeThemeEvent("dark"));
          },
          child: Row(
            children: [
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 20),
              const Icon(Icons.dark_mode),
            ],
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.read<ThemeBloc>().add(const ChangeThemeEvent("light"));
          },
          child: Row(
            children: [
              Text(
                "Light Mode",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 20),
              const Icon(
                Icons.light_mode,
                color: Colors.yellow,
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
