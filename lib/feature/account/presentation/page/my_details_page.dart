import 'dart:ui';

import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/account/domain/entities/my_details_entity.dart';
import 'package:fashion/feature/account/presentation/controller/myDetails/my_details_bloc.dart';
import 'package:fashion/feature/account/presentation/widget/my_details/text_form_field_details_widget.dart';
import 'package:fashion/feature/auth/domain/entities/users.dart';
import 'package:fashion/feature/auth/presentation/widgets/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_picker/country_picker.dart';
import '../../../../core/class/validators.dart';

String gender = "";

class MyDetailsPage extends StatelessWidget {
  MyDetailsPage({super.key, required this.user});
  final UserEntite user;
  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _brith = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _fullName.text = user.userFullName;
    _email.text = user.userEmail;
    _brith.text = user.birth!;
    gender = user.gender!;
    _phone.text = user.userPhone!;
    return BlocListener<MyDetailsBloc, MyDetailsState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          showSnacBarFun(context, state.errorMessage, Colors.redAccent);
        }
        if (state.successMessage.isNotEmpty) {
          showSnacBarFun(context, state.successMessage, Colors.greenAccent);
          context.pop();
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  TitlePageWidget(
                    title: "My Details",
                    onPressed: () => context.pop(),
                  ),
                  Divider(color: Theme.of(context).colorScheme.surface),
                  const SizedBox(height: 20),
                  Form(
                    key: _myKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldDetailsWidget(
                          title: "Full Name",
                          validator: (val) {
                            return Validators(context)
                                .validatRequirdFullName(val);
                          },
                          controller: _fullName,
                          bottom: 20,
                        ),
                        TextFormFieldDetailsWidget(
                          title: "Email Address",
                          validator: (val) {
                            return Validators(context).emailValid(val);
                          },
                          controller: _email,
                          bottom: 20,
                        ),
                        TextFormFieldDetailsWidget(
                          title: "Date of brith",
                          validator: (val) {
                            return;
                          },
                          controller: _brith,
                          prefixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onTap: () async {
                            final DateTime? dateTime = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2050));
                            if (dateTime != null) {
                              _brith.text =
                                  "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                            }
                          },
                          bottom: 20,
                          keyboardType: TextInputType.none,
                        ),
                        Text("Gender",
                            style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 4),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                          ),
                          value: user.gender,
                          items: const [
                            DropdownMenuItem(
                                value: "Male", child: Text("Male")),
                            DropdownMenuItem(
                                value: "Female", child: Text("Female")),
                          ],
                          onChanged: (value) {
                            gender = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldDetailsWidget(
                          title: "Phone Number",
                          validator: (val) {
                            return Validators(context).phoneValidate(val);
                          },
                          controller: _phone,
                          prefixIcon: GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 600,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    inputDecoration: const InputDecoration(
                                      hintText: "Search your country Here",
                                    )),
                                onSelect: (countryChange) {
                                  context.read<MyDetailsBloc>().add(
                                      ChoosYourCountryEvent(
                                          countryChange.flagEmoji,
                                          countryChange.phoneCode));
                                },
                              );
                            },
                            child: BlocBuilder<MyDetailsBloc, MyDetailsState>(
                              builder: (context, state) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  height: 55,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(state.flagEmoji),
                                      Text(
                                          textDirection: TextDirection.ltr,
                                          " +${state.phoneCode} "),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          bottom: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _onTap(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 54,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "submet",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              BlocSelector<MyDetailsBloc, MyDetailsState, bool>(
                selector: (state) => state.loadingUpdate,
                builder: (context, loading) {
                  return loading
                      ? BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Center(
                            child: CircularProgressIndicator(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        )
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (user.userFullName == _fullName.text &&
        user.userEmail == _email.text &&
        user.birth == _brith.text &&
        user.gender == gender &&
        user.userPhone == _phone.text) {
      showSnacBarFun(context, "you dont change any detail", Colors.redAccent);
    } else {
      if (_myKey.currentState!.validate()) {
        final MyDetailsEntity myDetailsEntity = MyDetailsEntity(
          userID: user.userId!,
          fullName: _fullName.text,
          email: _email.text,
          brith: _brith.text,
          gender: gender,
          phone: _phone.text,
        );

        context
            .read<MyDetailsBloc>()
            .add(UpDateMyDetailsEvent(myDetailsEntity, user.userImage!));
      }
    }
  }
}
