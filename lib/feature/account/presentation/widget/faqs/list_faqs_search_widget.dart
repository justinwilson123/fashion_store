import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/empty_page_widget.dart';
import '../../controller/faqs/fa_qs_bloc.dart';

class ListFaqsSearchWidget extends StatelessWidget {
  const ListFaqsSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: BlocBuilder<FaQsBloc, FaQsState>(
        builder: (context, state) {
          return !state.searchLoading && state.searchFAQs.isEmpty
              ? const EmptyPageWidget(
                  icon: Icons.question_mark,
                  title: "Not Found Question",
                  subTitle: "No Question",
                  showRefreshButton: false,
                )
              : state.searchLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, i) => const SizedBox(height: 20),
                      itemCount: state.searchFAQs.length,
                      itemBuilder: (constext, i) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ExpansionTile(
                            shape: Border.all(style: BorderStyle.none),
                            collapsedShape: Border.all(style: BorderStyle.none),
                            title: Text(state.searchFAQs[i].question),
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                    left: 20,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    state.searchFAQs[i].answer,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  )),
                            ],
                          ),
                        );
                      });
        },
      ),
    );
  }
}
