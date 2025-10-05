import 'package:fashion/core/function/translate_from_api.dart';
import 'package:fashion/feature/search/presentation/controller/controller/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchesWidget extends StatelessWidget {
  const RecentSearchesWidget({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Searches",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextButton(
              onPressed: () {
                context.read<SearchBloc>().add(RemoveAllCachedResultEvent());
              },
              child: Text(
                "Clear all",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return state.fromCached.isEmpty
                  ? Center(
                      child: Text("You have not searched for any product yet"),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, _) => Divider(
                        color: Theme.of(context).colorScheme.surface,
                        thickness: 1,
                      ),
                      itemCount: state.fromCached.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 53,
                          child: ListTile(
                            onTap: () {
                              context.read<SearchBloc>().add(
                                GetResultSearchEvent(
                                  state.fromCached[index].nameEn,
                                ),
                              );
                              controller.text = translateFromApi(
                                context,
                                state.fromCached[index].nameEn,
                                state.fromCached[index].nameAr,
                              );
                            },
                            title: Text(
                              translateFromApi(
                                context,
                                state.fromCached[index].nameEn,
                                state.fromCached[index].nameAr,
                              ),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<SearchBloc>().add(
                                  RemoveOneResultFromCachedEvent(index),
                                );
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
