import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widget/setting/change_language_widget.dart';
import '../widget/setting/change_mode_widget.dart';

class SettingAppPage extends StatelessWidget {
  const SettingAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SafeArea(
        child: Column(
          children: [
            TitlePageWidget(
              title: "Setting App",
              onPressed: () => context.pop(),
            ),
            const SizedBox(height: 20),
            Divider(color: Theme.of(context).colorScheme.surface),
            const SizedBox(height: 20),
            const ChangeLanguageWidget(),
            const SizedBox(height: 20),
            const ChangeModeWidget(),
          ],
        ),
      ),
    );
  }
}
