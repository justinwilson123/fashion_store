import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> name = [
      "Customer Service",
      "WhatsApp",
      "Websit",
      "Facebook",
      "twitter",
      "Instagram",
    ];
    List iconsAndAssets = [
      Icons.headset_mic_outlined,
      "assets/image/Whatsapp.png",
      Icons.web,
      Icons.facebook_sharp,
      "assets/image/Twitter.png",
      "assets/image/Instagram.png",
    ];
    List<Uri> uris = [
      Uri.parse("https://wa.me/qr/AUPO6RGQCO22P1"),
      Uri.parse("https://google.com"),
      Uri.parse("https://www.facebook.com/share/1Dp3q4PPoj/"),
      Uri.parse("https://x.com/elonmusk?t=o3aEuYQkx8I8jIDrJp6DBA&s=09"),
      Uri.parse(
          "https://www.instagram.com/alaa.alshemali?igsh=N3I5NXFmZTRpMXkx"),
    ];
    return Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              TitlePageWidget(
                title: "Help Center",
                onPressed: () => context.pop(),
              ),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (_, i) => const SizedBox(height: 20),
                itemCount: name.length,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () async {
                        i == 0
                            ? context.pushNamed(NameAppRoute.customerService)
                            : await launchUrl(uris[i - 1]);
                      },
                      title: Text(name[i]),
                      leading: i == 1 || i == 4 || i == 5
                          ? Image.asset(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              iconsAndAssets[i],
                              height: 24,
                              width: 24,
                            )
                          : Icon(iconsAndAssets[i]),
                    ),
                  );
                },
              ))
            ],
          ),
        ));
  }
}
