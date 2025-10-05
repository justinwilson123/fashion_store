import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/class/validators.dart';
import '../../../../../core/constant/name_app_route.dart';
import '../../controller/reset_password/reset_password/reset_password_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/show_sncak_bar_widget.dart';
import '../../widgets/signup_login_button.dart';
import '../../widgets/text_field_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  ResetPasswordScreen({super.key, required this.email});

  final TextEditingController _password = TextEditingController();
  final TextEditingController _rePassword = TextEditingController();
  final GlobalKey<FormState> _passKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _rePassKey = GlobalKey<FormState>();
  final bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.successMessage.isNotEmpty) {
          showSnacBarFun(
            context,
            state.successMessage.tr(context),
            Colors.greenAccent,
          );
          context.goNamed(NameAppRoute.login);
        }
        if (state.errorMessage.isNotEmpty) {
          showSnacBarFun(
            context,
            state.errorMessage.tr(context),
            Colors.redAccent,
          );
        }
      },
      child: _buildBody(context),
    ));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 70,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                        onPressed: () {
                          context.goNamed(NameAppRoute.enterEmail);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    _titleText(context),
                    _buidPasswordField(),
                    _buildRePasswrdField(),
                    const Spacer(),
                    _continueButton()
                  ],
                ),
              ),
            ),
            _buildLoading(),
          ],
        ),
      ),
    );
  }

  BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>
      _buidPasswordField() {
    return BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>(
      selector: (state) => state.validPass,
      builder: (context, validPass) {
        return BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>(
          selector: (state) => state.showePass,
          builder: (context, showePass) {
            return TextFieldWidget(
              title: "6".tr(context),
              myKey: _passKey,
              bottom: 10,
              onChanged: (_) {
                _validPasswordField(context);
                _validRePasswordField(context);
              },
              obscureText: showePass,
              validator: (val) {
                // _rePassKey.currentState!.validate();
                return Validators(context).passValidate(val);
              },
              controller: _password,
              hintText: "7".tr(context),
              color: validPass ? Colors.green : Colors.grey,
              prefixIcon: IconButton(
                icon: showePass
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
                onPressed: () {
                  context
                      .read<ResetPasswordBloc>()
                      .add(ShowePasswordEvent(showePass ? false : true));
                },
              ),
              suffix: validPass,
            );
          },
        );
      },
    );
  }

  BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>
      _buildRePasswrdField() {
    return BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>(
      selector: (state) => state.validRepass,
      builder: (context, validRePass) {
        return BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>(
          selector: (state) => state.showeRepass,
          builder: (context, showeRepass) {
            return TextFieldWidget(
              title: "6".tr(context),
              myKey: _rePassKey,
              bottom: 0.0,
              onChanged: (_) {
                _validRePasswordField(context);
                _validPasswordField(context);
              },
              obscureText: showeRepass,
              validator: (val) {
                if (_password.text != val) {
                  return "39".tr(context);
                } else {
                  return null;
                }
              },
              controller: _rePassword,
              hintText: "7".tr(context),
              color: validRePass ? Colors.green : Colors.grey,
              prefixIcon: IconButton(
                icon: showeRepass
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
                onPressed: () {
                  context.read<ResetPasswordBloc>().add(
                        ShoweRePasswordEvent(showeRepass ? false : true),
                      );
                },
              ),
              suffix: validRePass,
            );
          },
        );
      },
    );
  }

  BlocSelector<ResetPasswordBloc, ResetPasswordState, bool> _buildLoading() {
    return BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingWidget(isLoading: isLoading);
      },
    );
  }

  Widget _titleText(BuildContext context) {
    return SizedBox(
      height: 84,
      width: 341,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "40".tr(context),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            "41".tr(context),
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }

  BlocSelector<ResetPasswordBloc, ResetPasswordState, bool> _continueButton() {
    return BlocSelector<ResetPasswordBloc, ResetPasswordState, bool>(
      selector: (state) => state.validAll,
      builder: (context, validAll) {
        return MainButton(
          color: validAll,
          text: "42".tr(context),
          onPressed: () {
            if (validAll) {
              context
                  .read<ResetPasswordBloc>()
                  .add(GoToResetPasswordEvent(email, _password.text));
            }
          },
          vertical: 5,
        );
      },
    );
  }

  _validPasswordField(BuildContext context) {
    if (_passKey.currentState!.validate()) {
      context
          .read<ResetPasswordBloc>()
          .add(const ValidPasswordFiledEvent(true));
    } else {
      context
          .read<ResetPasswordBloc>()
          .add(const ValidPasswordFiledEvent(false));
    }
  }

  _validRePasswordField(BuildContext context) {
    if (_rePassKey.currentState!.validate()) {
      context
          .read<ResetPasswordBloc>()
          .add(const ValidRePasswordFiledEvent(true));
    } else {
      context
          .read<ResetPasswordBloc>()
          .add(const ValidRePasswordFiledEvent(false));
    }
  }
}
