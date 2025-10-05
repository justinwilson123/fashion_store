import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/name_app_route.dart';
import '../../controller/reset_password/verifi_email_for_reset/verifi_email_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/otp_input_widget.dart';
import '../../widgets/show_sncak_bar_widget.dart';
import '../../widgets/signup_login_button.dart';
import '../../widgets/text_text_button.dart';

class VerifiEamilForResetPassScreen extends StatelessWidget {
  final String email;
  VerifiEamilForResetPassScreen({super.key, required this.email});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleText(context),
                _otp(context),
                _resendVeifiCode(context),
                const Spacer(),
                _continueButonAndShoweMessage(context),
              ],
            ),
            _isLoading(),
          ],
        ),
      ),
    );
  }

  OtpInputWidget _otp(BuildContext context) {
    return OtpInputWidget(
      length: 4,
      controller: controller,
      onChanged: (_) {
        // _validOtp(context);
        if (controller.text.length == 4) {
          context
              .read<VerifiEmailBloc>()
              .add(const CompleatFillFiledCodeEvent(true));
        } else {
          context
              .read<VerifiEmailBloc>()
              .add(const CompleatFillFiledCodeEvent(false));
        }
      },
    );
  }

  TextTextButton _resendVeifiCode(BuildContext context) {
    return TextTextButton(
      text: "43".tr(context),
      buttonText: "44".tr(context),
      onPressed: () {
        context.read<VerifiEmailBloc>().add(ResendVerifiCodeEmail(email));
      },
    );
  }

  BlocListener<VerifiEmailBloc, VerifiEmailState> _continueButonAndShoweMessage(
      BuildContext context) {
    return BlocListener<VerifiEmailBloc, VerifiEmailState>(
        listener: (_, state) {
          if (state.successMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.successMessage.tr(context),
              Colors.greenAccent,
            );

            context.pushNamed(NameAppRoute.resetaPassword,
                pathParameters: {"email": email});
          }
          if (state.errorMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.errorMessage.tr(context),
              Colors.redAccent,
            );
          }
          if (state.errorResendMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.errorResendMessage.tr(context),
              Colors.redAccent,
            );
          }
          if (state.successResendMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.successResendMessage.tr(context),
              Colors.greenAccent,
            );
          }
        },
        child: BlocSelector<VerifiEmailBloc, VerifiEmailState, bool>(
          selector: (state) => state.isCompleated,
          builder: (context, isCompleated) {
            return MainButton(
              color: isCompleated,
              text: "42".tr(context),
              onPressed: () {
                context
                    .read<VerifiEmailBloc>()
                    .add(SendVerifiCodeEvent(email, controller.text));
              },
              vertical: 25,
            );
          },
        ));
  }

  BlocSelector<VerifiEmailBloc, VerifiEmailState, bool> _isLoading() {
    return BlocSelector<VerifiEmailBloc, VerifiEmailState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingWidget(isLoading: isLoading);
      },
    );
  }

  Widget _titleText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
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

  // _validOtp(BuildContext context) {
  //   if (controller.text.length == 4) {
  //     context
  //         .read<VerifiEmailBloc>()
  //         .add(const CompleatFillFiledCodeEvent(true));
  //   } else {
  //     context
  //         .read<VerifiEmailBloc>()
  //         .add(const CompleatFillFiledCodeEvent(false));
  //   }
  // }
}
