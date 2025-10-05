import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/name_app_route.dart';
import '../controller/onbording/onboarding_bloc.dart';

class Onbording extends StatelessWidget {
  const Onbording({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/Onboarding.jpg"),
              fit: BoxFit.fill)),
      child: Container(
        height: 107,
        alignment: Alignment.center,
        color: Colors.white,
        child: MaterialButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(SeenOnbordingScreenEvent());
            context.goNamed(NameAppRoute.login);
          },
          child: Container(
            // alignment: Alignment.topCenter,
            height: 54,
            width: 341,
            padding: const EdgeInsets.symmetric(horizontal: 84, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1".tr(context),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Directionality(
                  textDirection: TextDirection.rtl,
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
