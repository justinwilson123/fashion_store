import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/class/validators.dart';
import '../../../../../core/constant/name_app_route.dart';
import '../../controller/signup/signup/signup_bloc.dart';
import '../../widgets/facebook_google_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/privacy_policy_widget.dart';
import '../../widgets/show_sncak_bar_widget.dart';
import '../../widgets/signup_login_button.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/text_text_button.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _fullNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.seccessMessage.isNotEmpty) {
              showSnacBarFun(context, state.seccessMessage.tr(context),
                  Colors.greenAccent);
              if (state.seccessMessage == "Your google has been created") {
                context.goNamed(NameAppRoute.login);
              } else {
                context.goNamed(NameAppRoute.verifiSignUp,
                    pathParameters: {"email": _email.text});
              }
            } else if (state.errorMessage.isNotEmpty) {
              showSnacBarFun(
                  context, state.errorMessage.tr(context), Colors.redAccent);
            }
          },
          child: _body(context),
        ));
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(context),
                  _subTitle(context),

// ========================== full Name filed ==============================
                  _fullNameField(),

// ========================== Email filed ==============================
                  _emailField(),

// ========================== Phone filed ==============================
                  _phoneField(),

// ========================== password filed ==============================
                  _passwordField(),

// =============================PrivacyPolicy================================
                  const PrivacyPolicyWidget(),

// =============================Signup Button ====================================
                  _signUpButtonAndShoweMessage(),
                  const OrDivider(),

// ===============================facebook Google button =======================
                  _googleButton(context),
                  _facebookButton(context),

//============================LoginButton==============================
                  _buildGoLogin(context),
                ],
              ),
            ),
          ),

// ================================= Loading Effact ==========================
          _buildLoading(),
        ],
      ),
    );
  }

  SizedBox _title(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Text(
        "24".tr(context),
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Container _subTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 22,
      child: Text(
        "25".tr(context),
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  BlocSelector<SignupBloc, SignupState, bool> _fullNameField() {
    return BlocSelector<SignupBloc, SignupState, bool>(
      selector: (state) => state.validName,
      builder: (context, validFullName) {
        return TextFieldWidget(
          keyboardType: TextInputType.name,
          title: "26".tr(context),
          myKey: _fullNameKey,
          bottom: 10,
          onChanged: (_) {
            _validFullName(context);
          },
          obscureText: false,
          validator: (val) {
            return Validators(context).validatRequirdFullName(val);
          },
          controller: _fullName,
          hintText: "26".tr(context),
          color: validFullName ? Colors.green : Colors.grey,
          suffix: validFullName,
        );
      },
    );
  }

  BlocSelector<SignupBloc, SignupState, bool> _emailField() {
    return BlocSelector<SignupBloc, SignupState, bool>(
      selector: (state) => state.validEmail,
      builder: (context, validEmail) {
        return TextFieldWidget(
          title: "4".tr(context),
          myKey: _emailKey,
          bottom: 15,
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          onChanged: (_) {
            _validEmailField(context);
          },
          validator: (val) {
            return Validators(context).emailValid(val);
          },
          controller: _email,
          hintText: "5".tr(context),
          color: validEmail ? Colors.green : Colors.grey,
          suffix: validEmail,
        );
      },
    );
  }

  BlocSelector<SignupBloc, SignupState, bool> _phoneField() {
    return BlocSelector<SignupBloc, SignupState, bool>(
      selector: (state) => state.validNummberPhone,
      builder: (context, validPhone) {
        return TextFieldWidget(
          keyboardType: TextInputType.phone,
          title: "27".tr(context),
          myKey: _phoneKey,
          bottom: 10.0,
          onChanged: (_) {
            _validPhone(context);
          },
          obscureText: false,
          validator: (val) {
            return Validators(context).phoneValidate(val);
          },
          controller: _phone,
          hintText: "7".tr(context),
          color: validPhone ? Colors.green : Colors.grey,
          suffix: validPhone,
        );
      },
    );
  }

  BlocSelector<SignupBloc, SignupState, bool> _passwordField() {
    return BlocSelector<SignupBloc, SignupState, bool>(
      selector: (state) => state.validPass,
      builder: (context, validPass) {
        return BlocSelector<SignupBloc, SignupState, bool>(
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
                  {
                    context.read<SignupBloc>().add(
                        ShowAndHidPasswordSignupEvent(
                            !showePass ? true : false));
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

  BlocSelector<SignupBloc, SignupState, bool> _signUpButtonAndShoweMessage() {
    return BlocSelector<SignupBloc, SignupState, bool>(
      selector: (state) => state.validAllField,
      builder: (context, validAll) {
        return MainButton(
          vertical: 5,
          onPressed: () {
            if (validAll) {
              context.read<SignupBloc>().add(GoSignupEvent(
                    _fullName.text,
                    _email.text,
                    _phone.text,
                    _password.text,
                  ));
            }
          },
          color: validAll,
          text: "29".tr(context),
        );
      },
    );
  }

  FacebookGoogleButton _googleButton(BuildContext context) {
    return FacebookGoogleButton(
      text: "30".tr(context),
      onPressed: () async {
        context.read<SignupBloc>().add(const SignUpWithGoogleEvent());
      },
      color: Colors.white,
      google: true,
    );
  }

  FacebookGoogleButton _facebookButton(BuildContext context) {
    return FacebookGoogleButton(
      text: "31".tr(context),
      onPressed: () {},
      color: Colors.blue,
      google: false,
    );
  }

  TextTextButton _buildGoLogin(BuildContext context) {
    return TextTextButton(
      text: "34".tr(context),
      buttonText: "35".tr(context),
      onPressed: () {
        context.goNamed(NameAppRoute.login);
      },
    );
  }

  BlocSelector<SignupBloc, SignupState, bool> _buildLoading() {
    return BlocSelector<SignupBloc, SignupState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingWidget(isLoading: isLoading);
      },
    );
  }

  // ========================== function For Add event =============================
  _validFullName(BuildContext context) {
    if (_fullNameKey.currentState!.validate()) {
      context.read<SignupBloc>().add(const ValidateFullNameSignUpEvent(true));
    } else {
      context.read<SignupBloc>().add(const ValidateFullNameSignUpEvent(false));
    }
  }

  _validPassword(BuildContext context) {
    if (_passKey.currentState!.validate()) {
      context.read<SignupBloc>().add(const ValidatePassFiledSignupEvent(
            passValidate: true,
          ));
    } else {
      context.read<SignupBloc>().add(const ValidatePassFiledSignupEvent(
            passValidate: false,
          ));
    }
  }

  _validPhone(BuildContext context) {
    if (_phoneKey.currentState!.validate()) {
      context.read<SignupBloc>().add(const ValidatePhoneSignupEvent(true));
    } else {
      context.read<SignupBloc>().add(const ValidatePhoneSignupEvent(false));
    }
  }

  _validEmailField(BuildContext context) {
    if (_emailKey.currentState!.validate()) {
      context
          .read<SignupBloc>()
          .add(const ValidateEmailFiledSignupEvent(emailValidate: true));
    } else {
      context
          .read<SignupBloc>()
          .add(const ValidateEmailFiledSignupEvent(emailValidate: false));
    }
  }
}
