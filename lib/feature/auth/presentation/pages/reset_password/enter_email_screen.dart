import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/class/validators.dart';
import '../../../../../core/constant/name_app_route.dart';
import '../../controller/reset_password/enter_email/enter_email_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/show_sncak_bar_widget.dart';
import '../../widgets/signup_login_button.dart';
import '../../widgets/text_field_widget.dart';

class EnterEmailScreen extends StatelessWidget {
  EnterEmailScreen({super.key});

  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // toolbarHeight: 30,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(context),
                _subTitle(context),
                _emailField(),
                const Spacer(),
                _builSendCodeButton()
              ],
            ),
          ),
          _loadingWidget(),
        ],
      ),
    );
  }

  Container _title(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 32,
      child: Text(
        "36".tr(context),
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Container _subTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      height: 25,
      child: Text(
        "37".tr(context),
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  BlocSelector<EnterEmailBloc, EnterEmailState, bool> _emailField() {
    return BlocSelector<EnterEmailBloc, EnterEmailState, bool>(
      selector: (state) => state.isValidEmail,
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

  BlocListener<EnterEmailBloc, EnterEmailState> _builSendCodeButton() {
    return BlocListener<EnterEmailBloc, EnterEmailState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            showSnacBarFun(
                context, state.errorMessage.tr(context), Colors.redAccent);
          } else if (state.successMessage.isNotEmpty) {
            showSnacBarFun(
                context, state.successMessage.tr(context), Colors.greenAccent);
            context.pushNamed(NameAppRoute.verifiPass,
                pathParameters: {"email": _email.text});
          }
        },
        child: BlocSelector<EnterEmailBloc, EnterEmailState, bool>(
          selector: (state) => state.isValidEmail,
          builder: (context, validAll) {
            return MainButton(
              vertical: 30,
              onPressed: () {
                context
                    .read<EnterEmailBloc>()
                    .add(SendEamilForSendVerifiCode(_email.text));
              },
              color: validAll,
              text: "38".tr(context),
            );
          },
        ));
  }

  BlocSelector<EnterEmailBloc, EnterEmailState, bool> _loadingWidget() {
    return BlocSelector<EnterEmailBloc, EnterEmailState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingWidget(isLoading: isLoading);
      },
    );
  }

  _validEmailField(BuildContext context) {
    if (_emailKey.currentState!.validate()) {
      context.read<EnterEmailBloc>().add(const ValidEmailFaildEvent(true));
    } else {
      context.read<EnterEmailBloc>().add(const ValidEmailFaildEvent(false));
    }
  }
}
