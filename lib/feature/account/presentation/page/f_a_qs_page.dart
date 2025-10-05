import 'package:fashion/core/widget/empty_page_widget.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/account/presentation/controller/faqs/fa_qs_bloc.dart';
import 'package:fashion/feature/account/presentation/widget/faqs/list_topic_faqs_widget.dart';
import 'package:fashion/feature/account/presentation/widget/faqs/search_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widget/faqs/list_faqs_search_widget.dart';
import '../widget/faqs/list_faqs_topic_widget.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 105,
            child: Column(
              children: [
                TitlePageWidget(
                  title: "FAQs",
                  onPressed: () => context.pop(),
                ),
                Divider(color: Theme.of(context).colorScheme.surface),
                const SizedBox(height: 20),
                const ListTopicFaqsWidget(),
                const SizedBox(height: 10),
                const SearchTextFormField(),
                const SizedBox(height: 10),
                Expanded(
                    child: Stack(
                  children: [
                    BlocBuilder<FaQsBloc, FaQsState>(
                      builder: (context, state) {
                        return !state.isLoading && state.fAQs.isEmpty
                            ? const EmptyPageWidget(
                                icon: Icons.question_mark,
                                title: "Not Found Question",
                                subTitle: "No Question",
                                showRefreshButton: false,
                              )
                            : state.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListFaqsTopicWidget(fAQs: state.fAQs);
                      },
                    ),
                    BlocSelector<FaQsBloc, FaQsState, String>(
                      selector: (state) => state.search,
                      builder: (context, search) {
                        return search == ""
                            ? Container()
                            : const ListFaqsSearchWidget();
                      },
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
