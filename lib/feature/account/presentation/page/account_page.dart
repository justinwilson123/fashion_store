import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../injiction_container.dart' as di;

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listName = [
      "My Order",
      "My Details",
      "Address Book",
      "Payment Method",
      "Setting App",
      "Notifications",
      "FAQs",
      "Help Center",
      "Logout",
    ];
    List<IconData> iconDataList = [
      Icons.inventory_2_outlined,
      Icons.person_outline,
      Icons.house_outlined,
      Icons.payment_outlined,
      Icons.settings_outlined,
      Icons.notifications_outlined,
      Icons.help_outline,
      Icons.headset_mic_outlined,
      Icons.logout_outlined,
    ];
    List<String> nameRoute = [
      NameAppRoute.myOrder,
      NameAppRoute.myDetails,
      "savedAddress",
      "savedCards",
      NameAppRoute.settingApp,
      NameAppRoute.settingNotification,
      NameAppRoute.fAQs,
      NameAppRoute.helpCenter,
    ];
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitlePageWidget(
              title: "Account",
              onPressed: () {
                context.goNamed(NameAppRoute.home);
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, i) => i == 0 || i == 5 || i == 7
                    ? Container(
                        color: Theme.of(context).colorScheme.surface,
                        height: 10,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                      )
                    : SizedBox(
                        height: 34,
                        child: Center(
                          child: Divider(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                itemCount: listName.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      final user = await di.sl<CachedUserInfo>().getUserInfo();
                      if (!context.mounted) return;
                      index != 8 && index == 1
                          ? context.pushNamed(nameRoute[index], extra: user)
                          : index != 8 && index != 1
                              ? context.pushNamed(nameRoute[index])
                              : _buildLogoutShowDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(
                              iconDataList[index],
                              color: index == 8 ? Colors.red : null,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              listName[index],
                              style: TextStyle(
                                color: index == 8 ? Colors.red : null,
                              ),
                            )
                          ]),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildLogoutShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 70,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Logout?",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Are you sure want to Logout?",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      di.sl<SharedPreferences>().clear();
                      context.goNamed(NameAppRoute.onBoarding);
                    },
                    child: Container(
                      height: 54,
                      width: 275,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Yes,Logout",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      height: 54,
                      width: 275,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "No,Cancel",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
