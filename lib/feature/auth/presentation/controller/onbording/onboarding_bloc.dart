import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/class/seen_secreen.dart';
import '../../../../../core/constant/name_app_route.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SeenSecreen seenSecreen;
  OnboardingBloc(this.seenSecreen) : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is SeenOnbordingScreenEvent) {
        seenSecreen.saveSeenScreen(NameAppRoute.onBoarding);
      }
    });
  }
}
