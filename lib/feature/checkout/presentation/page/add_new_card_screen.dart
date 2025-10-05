// import 'package:fashion/core/widget/empty_page_widget.dart';
import 'dart:ui';

import 'package:fashion/core/class/app_localization.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/auth/presentation/widgets/show.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/presentation/controller/add_card/add_card_bloc.dart';
import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:fashion/feature/checkout/presentation/widget/text_field_checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../injiction_container.dart' as di;
import '../../../../core/class/cached_user_info.dart';

class AddNewCardScreen extends StatelessWidget {
  AddNewCardScreen({super.key});
  final GlobalKey<FormState> _lastnumber = GlobalKey<FormState>();
  final GlobalKey<FormState> _cardBrand = GlobalKey<FormState>();
  final GlobalKey<FormState> _paymentMethod = GlobalKey<FormState>();
  final TextEditingController _lastnumberConterller = TextEditingController();
  final TextEditingController _cardBrandConterller = TextEditingController();
  final TextEditingController _paymentMethodConterller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context.read<CheckoutBloc>().add(const GetAllCardEvent());
          return true;
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: BlocListener<AddCardBloc, AddCardState>(
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                showSnacBarFun(
                  context,
                  state.errorMessage.tr(context),
                  Colors.red,
                );
              }
              if (state.successMessage.isNotEmpty) {
                _buildSeccessShowDialog(context);
              }
            },
            child: _buildBodyScreen(context),
          ),
        ),
      ),
    );
  }

  SafeArea _buildBodyScreen(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 70,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitlePageWidget(
                    title: "New Card",
                    onPressed: () {
                      context.read<CheckoutBloc>().add(const GetAllCardEvent());
                      context.pop();
                    },
                  ),
                  Divider(color: Theme.of(context).colorScheme.surface),
                  const SizedBox(height: 15),
                  Text(
                    "Add Debit or Credit Card",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 15),
                  _buildNumbeCardField(context),
                  const SizedBox(height: 20),
                  _buildPaymentAndBrandField(context),
                  const SizedBox(height: 10),
                  _buildIsDefaultCard(context),
                  const Spacer(),
                  _buildAddCardButton(),
                ],
              ),
            ),
          ),
          _buildLoading(),
        ],
      ),
    );
  }

  Future<dynamic> _buildSeccessShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 70,
                  color: Colors.greenAccent,
                ),
                const SizedBox(height: 20),
                Text(
                  "Congratulations!",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  "Your new card has been added.",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // context
                    //     .read<CheckoutBloc>()
                    //     .add(const GetAllCardEvent());
                    context.pop();
                  },
                  child: Container(
                    height: 54,
                    width: 275,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Thanks",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFieldCheckoutWidget _buildNumbeCardField(BuildContext context) {
    return TextFieldCheckoutWidget(
      formKey: _lastnumber,
      title: "Card number",
      color: Theme.of(context).colorScheme.surface,
      controller: _lastnumberConterller,
      hintText: "Enter Your Card Number",
      keyboardType: TextInputType.number,
      onChanged: (_) {
        if (_lastnumber.currentState!.validate()) {
          context.read<AddCardBloc>().add(const ValidCardNumberEvent(true));
        } else {
          context.read<AddCardBloc>().add(const ValidCardNumberEvent(false));
        }
      },
      validator: (val) {
        if (val!.isEmpty) {
          return "this field is required";
        } else if (val.length > 4) {
          return "shoud not be more than 4 number";
        } else {
          return null;
        }
      },
    );
  }

  Row _buildPaymentAndBrandField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldCheckoutWidget(
            formKey: _paymentMethod,
            title: "payment method",
            color: Theme.of(context).colorScheme.surface,
            controller: _paymentMethodConterller,
            hintText: "payment method",
            keyboardType: null,
            onChanged: (_) {
              if (_paymentMethod.currentState!.validate()) {
                context.read<AddCardBloc>().add(
                  const ValidPaymentMethodEvent(true),
                );
              } else {
                context.read<AddCardBloc>().add(
                  const ValidPaymentMethodEvent(false),
                );
              }
            },
            validator: (val) {
              if (val!.isEmpty) {
                return "this field is required";
              } else if (val.length > 10) {
                return "shoud not be more than 10 letter";
              } else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFieldCheckoutWidget(
            formKey: _cardBrand,
            title: "Card Brand",
            color: Theme.of(context).colorScheme.surface,
            controller: _cardBrandConterller,
            hintText: "card brand",
            keyboardType: TextInputType.name,
            onChanged: (_) {
              if (_cardBrand.currentState!.validate()) {
                context.read<AddCardBloc>().add(
                  const ValidCardBrandEvent(true),
                );
              } else {
                context.read<AddCardBloc>().add(
                  const ValidCardBrandEvent(false),
                );
              }
            },
            validator: (val) {
              if (val!.isEmpty) {
                return "this field is required";
              } else if (val.length > 10) {
                return "shoud not be more than 10 letter";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Row _buildIsDefaultCard(BuildContext context) {
    return Row(
      children: [
        BlocSelector<AddCardBloc, AddCardState, bool>(
          selector: (state) => state.isDefault,
          builder: (context, isDefault) {
            return Checkbox(
              activeColor: Theme.of(context).colorScheme.inversePrimary,
              value: isDefault,
              onChanged: (val) {
                context.read<AddCardBloc>().add(DefaultCardEvent(!val!));
              },
            );
          },
        ),
        Text(
          "Make this as default card",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }

  BlocBuilder<AddCardBloc, AddCardState> _buildAddCardButton() {
    return BlocBuilder<AddCardBloc, AddCardState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.validAll
              ? () async {
                  final user = await di.sl<CachedUserInfo>().getUserInfo();
                  final CardEntity card = CardEntity(
                    id: 0,
                    userID: user.userId!,
                    paymentMethod: _paymentMethodConterller.text,
                    cardLast4: _lastnumberConterller.text,
                    cardBrand: _cardBrandConterller.text,
                    isDefault: state.isDefault ? 1 : 0,
                  );
                  if (!context.mounted) return;
                  context.read<AddCardBloc>().add(AddNewCardEvent(card));
                }
              : null,
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              color: state.validAll
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Add Card",
                style: state.validAll
                    ? Theme.of(context).textTheme.headlineLarge
                    : Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        );
      },
    );
  }

  BlocSelector<AddCardBloc, AddCardState, bool> _buildLoading() {
    return BlocSelector<AddCardBloc, AddCardState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return isLoading
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/addcard.json",
                    height: 400,
                    width: 400,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
