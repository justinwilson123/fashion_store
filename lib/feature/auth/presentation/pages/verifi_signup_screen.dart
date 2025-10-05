import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/name_app_route.dart';
import '../controller/signup/verifi_signup/verifi_signup_bloc.dart';
import '../controller/signup/verifi_signup/verifi_signup_event.dart';
import '../controller/signup/verifi_signup/verifi_signup_state.dart';
import '../widgets/loading_widget.dart';
import '../widgets/otp_input_widget.dart';
import '../widgets/show_sncak_bar_widget.dart';
import '../widgets/signup_login_button.dart';
import '../widgets/text_text_button.dart';

class VerifiSignupScreen extends StatelessWidget {
  final String email;
  VerifiSignupScreen({super.key, required this.email});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VerifiSignupBloc, VerifiSignupState>(
        listener: (context, state) {
          if (state.successVerifiMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.successVerifiMessage.tr(context),
              Colors.greenAccent,
            );
            context.go(NameAppRoute.login);
          }
          if (state.errorVerifiMessage.isNotEmpty) {
            showSnacBarFun(context, state.errorVerifiMessage.tr(context),
                Colors.redAccent);
          }
          if (state.successResendVerifiMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.successResendVerifiMessage.tr(context),
              Colors.greenAccent,
            );
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _titleText(context),
                  _buildOtp(context),
                  _buildResendCode(context),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
          _buildLoading()
        ],
      ),
    );
  }

  OtpInputWidget _buildOtp(BuildContext context) {
    return OtpInputWidget(
      length: 4,
      controller: controller,
      onChanged: (value) {
        if (value.length < 4) {
          context
              .read<VerifiSignupBloc>()
              .add(const CompleatFillFiledVerifiCodeEvent(false));
        } else {
          context
              .read<VerifiSignupBloc>()
              .add(const CompleatFillFiledVerifiCodeEvent(true));
        }
      },
    );
  }

  TextTextButton _buildResendCode(BuildContext context) {
    return TextTextButton(
      text: "43".tr(context),
      buttonText: "44".tr(context),
      onPressed: () {
        context.read<VerifiSignupBloc>().add(ResendVerifiCodeEvent(email));
      },
    );
  }

  BlocSelector<VerifiSignupBloc, VerifiSignupState, bool>
      _buildContinueButton() {
    return BlocSelector<VerifiSignupBloc, VerifiSignupState, bool>(
      selector: (state) => state.isCompleated,
      builder: (context, isCompleated) {
        return MainButton(
          color: isCompleated,
          text: "42".tr(context),
          onPressed: () {
            context
                .read<VerifiSignupBloc>()
                .add(SendVerifiCodeForVerifiEmailEvent(email, controller.text));
          },
          vertical: 30,
        );
      },
    );
  }

  Widget _titleText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: 341,
      height: 84,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "45".tr(context),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            "${"46".tr(context)}($email)",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }

  BlocSelector<VerifiSignupBloc, VerifiSignupState, bool> _buildLoading() {
    return BlocSelector<VerifiSignupBloc, VerifiSignupState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingWidget(isLoading: isLoading);
      },
    );
  }
}
