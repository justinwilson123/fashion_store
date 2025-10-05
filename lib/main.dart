import 'package:fashion/core/theme/bloc/theme_bloc.dart';
import 'package:fashion/feature/home/presentation/controller/controller/home_bloc_bloc.dart';
import 'package:fashion/feature/notification/presentation/controller/controller/notification_bloc.dart';
import 'package:fashion/firebase_options.dart';
import 'package:fashion/go_router.dart';
import 'package:fashion/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/class/app_localization.dart';
import 'core/translation/lang_bloc/language_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'feature/saved/presentation/controller/controller/saved_bloc.dart';
import 'injiction_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<LanguageBloc>()..add(GetCurrentLangEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<ThemeBloc>()..add(const GetThemeEvent()),
        ),
        BlocProvider(create: (_) => di.sl<SavedBloc>()),
        BlocProvider(
          create: (_) => di.sl<HomeBloc>()
            ..add(const GetGategoreisEvent())
            ..add(const GetAllProductEvent())
            ..add(const GetMaxPriceAllProductEvent()),
        ),
        BlocProvider(create: (_) => di.sl<NotificationBloc>()),
        BlocProvider(
          create: (_) => di.sl<CheckoutBloc>()
            ..add(const GetDefaultLoctionEvent())
            ..add(const GetDefaultCardEvent()),
        ),
      ],
      child: BlocSelector<LanguageBloc, LanguageState, String>(
        selector: (state) => state.langCode,
        builder: (context, langCode) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              if (state is ChangeThemeState) {
                return MaterialApp.router(
                  theme: state.themeData,
                  debugShowCheckedModeBanner: false,
                  locale: langCode.isNotEmpty ? Locale(langCode) : null,
                  supportedLocales: const [Locale("en"), Locale("ar")],
                  localizationsDelegates: const [
                    AppLocalizationn.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    for (var locale in supportedLocales) {
                      if (deviceLocale != null &&
                          deviceLocale.languageCode == locale.languageCode) {
                        return deviceLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  routerConfig: AppRouter().goRouter,
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
