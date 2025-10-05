import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/search/presentation/widget/field_widget.dart';
import 'package:fashion/feature/search/presentation/widget/result_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/recent_searches_widget.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SafeArea(
        child: Column(
          children: [
            TitlePageWidget(
              title: "Search",
              onPressed: () {
                context.goNamed(NameAppRoute.home);
              },
            ),
            FieldWidget(controller: controller),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  RecentSearchesWidget(controller: controller),
                  ResultSearchWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
