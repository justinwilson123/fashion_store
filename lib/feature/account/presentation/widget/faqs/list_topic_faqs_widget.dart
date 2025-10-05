import 'package:fashion/feature/account/presentation/controller/faqs/fa_qs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTopicFaqsWidget extends StatelessWidget {
  const ListTopicFaqsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> topic = ["General", "Account", "Service", "Payment"];
    return BlocSelector<FaQsBloc, FaQsState, int>(
      selector: (state) => state.initIndex,
      builder: (context, index) {
        return SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, i) => const SizedBox(width: 10),
            itemCount: topic.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  context.read<FaQsBloc>().add(ChangeIndexEvent(i, topic[i]));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: i == index
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: i == index
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.surface)),
                  child: Center(
                      child: Text(
                    topic[i],
                    style: i == index
                        ? Theme.of(context).textTheme.headlineLarge
                        : Theme.of(context).textTheme.bodyMedium,
                  )),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
