import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/class/validators.dart';
import '../../../../../core/constant/name_app_route.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../controller/login/login_bloc.dart';
import '../../widgets/facebook_google_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/show_sncak_bar_widget.dart';
import '../../widgets/signup_login_button.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/text_text_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _passKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (_, state) {
            if (state.seccessMessage.isNotEmpty) {
              context.goNamed(NameAppRoute.home);
            } else if (state.errorMessage.isNotEmpty) {
              showSnacBarFun(
                  context, state.errorMessage.tr(context), Colors.redAccent);
            }
            if (state.errorMessage == EMAIL_NOT_VERIFIED) {
              context.goNamed(NameAppRoute.verifiSignUp,
                  pathParameters: {"email": LoginBloc.email.text});
            }
          },
          child: _body(context),
        ));
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(context),
                _subTitle(context),

                // ============================== Eamil Field =========================

                _emailField(),

                // ========================== password filed ==============================
                _passwordField(),
                // =============================Reset Password================================
                _forgetPassword(context),

                // =============================Login Button ====================================
                _loginButtonAndShoweMessage(),
                const OrDivider(),

                // ===============================facebook Google button =======================
                _googleButton(context),
                facebookButton(context),
                // Spacer(),
                _goToSignUp(context),
              ],
            ),
          ),
        ),

        // ================================= Loading Effact ==========================
        _buildLoading(),
      ],
    );
  }

  Container _title(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 32,
      child: Text(
        "2".tr(context),
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Container _subTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 22,
      child: Text(
        "3".tr(context),
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  BlocSelector<LoginBloc, LoginState, bool> _emailField() {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.validEmail,
      builder: (context, validEmail) {
        return TextFieldWidget(
          title: "4".tr(context),
          myKey: _emailKey,
          bottom: 15,
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          onChanged: (val) {
            _validEmailField(context);
          },
          validator: (val) {
            return Validators(context).emailValid(val);
          },
          controller: LoginBloc.email,
          hintText: "5".tr(context),
          color: validEmail ? Colors.green : Colors.grey,
          suffix: validEmail,
        );
      },
    );
  }

  BlocSelector<LoginBloc, LoginState, bool> _passwordField() {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.validPass,
      builder: (context, validPass) {
        return BlocSelector<LoginBloc, LoginState, bool>(
          selector: (state) => state.showePass,
          builder: (context, showePass) {
            return TextFieldWidget(
              title: "6".tr(context),
              myKey: _passKey,
              bottom: 0.0,
              onChanged: (_) {
                _validPassword(context);
              },
              obscureText: showePass,
              validator: (val) {
                return Validators(context).validatRequird(val);
              },
              controller: LoginBloc.password,
              hintText: "7".tr(context),
              color: validPass ? Colors.green : Colors.grey,
              prefixIcon: IconButton(
                icon: showePass
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
                onPressed: () {
                  {
                    context.read<LoginBloc>().add(
                        ShowAndHidPasswordEvent(!showePass ? true : false));
                  }
                },
              ),
              suffix: validPass,
            );
          },
        );
      },
    );
  }

  TextTextButton _forgetPassword(BuildContext context) {
    return TextTextButton(
      onPressed: () {
        context.pushNamed(NameAppRoute.enterEmail);
      },
      text: "8".tr(context),
      buttonText: "9".tr(context),
    );
  }

  BlocSelector<LoginBloc, LoginState, bool> _loginButtonAndShoweMessage() {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.validAllField,
      builder: (context, validAll) {
        return MainButton(
          vertical: 15,
          onPressed: () {
            if (validAll) {
              context.read<LoginBloc>().add(GoLoginEvent(
                    LoginBloc.email.text,
                    LoginBloc.password.text,
                  ));
            }
          },
          color: validAll,
          text: "10".tr(context),
        );
      },
    );
  }

  BlocListener<LoginBloc, LoginState> _googleButton(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.seccessMessage.isNotEmpty) {
          context.goNamed(NameAppRoute.home);
        }
      },
      child: FacebookGoogleButton(
        text: "21".tr(context),
        onPressed: () {
          context.read<LoginBloc>().add(const GoLoginWithGoogleEvent());
        },
        color: Colors.white,
        google: true,
      ),
    );
  }

  FacebookGoogleButton facebookButton(BuildContext context) {
    return FacebookGoogleButton(
      text: "22".tr(context),
      onPressed: () {},
      color: Colors.blue,
      google: false,
    );
  }

  Expanded _goToSignUp(BuildContext context) {
    return Expanded(
      child: TextTextButton(
        text: "11".tr(context),
        buttonText: "12".tr(context),
        onPressed: () {
          context.pushReplacementNamed(NameAppRoute.signUp);
        },
      ),
    );
  }

  BlocSelector<LoginBloc, LoginState, bool> _buildLoading() {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingWidget(isLoading: isLoading);
      },
    );
  }

  // ========================== function For Add event =============================

  _validPassword(BuildContext context) {
    if (_passKey.currentState!.validate()) {
      context.read<LoginBloc>().add(const ValidatePassFiledLogInEvent(
            passValidate: true,
          ));
    } else {
      context.read<LoginBloc>().add(const ValidatePassFiledLogInEvent(
            passValidate: false,
          ));
    }
  }

  _validEmailField(BuildContext context) {
    if (_emailKey.currentState!.validate()) {
      context
          .read<LoginBloc>()
          .add(const ValidateEmailFiledLogInEvent(emailValidate: true));
    } else {
      context
          .read<LoginBloc>()
          .add(const ValidateEmailFiledLogInEvent(emailValidate: false));
    }
  }
}
