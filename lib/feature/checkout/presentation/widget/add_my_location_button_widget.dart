import 'package:fashion/feature/checkout/presentation/widget/text_field_checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/class/cached_user_info.dart';
import '../../domin/entity/checkout_entities.dart';
import '../controller/add_loaction/add_location_bloc.dart';
import '../../../../injiction_container.dart' as di;

class AddMyLocationButtonWidget extends StatelessWidget {
  const AddMyLocationButtonWidget({
    super.key,
    required this.addressName,
    required this.fullAddress,
    required this.addressNameController,
    required this.fullAddressController,
  });
  final GlobalKey<FormState> addressName;
  final GlobalKey<FormState> fullAddress;
  final TextEditingController addressNameController;
  final TextEditingController fullAddressController;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
          onTap: () {
            showBottomSheet(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              showDragHandle: true,
              context: context,
              builder: (_) {
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                "Address",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(color: Theme.of(context).colorScheme.surface),
                        const SizedBox(height: 10),
                        TextFieldCheckoutWidget(
                          formKey: addressName,
                          title: "Addrss Nickname",
                          color: Theme.of(context).colorScheme.surface,
                          controller: addressNameController,
                          hintText: "Name Address",
                          keyboardType: TextInputType.name,
                          onChanged: (_) {
                            if (addressName.currentState!.validate()) {
                              context
                                  .read<AddLocationBloc>()
                                  .add(const ValidNameLocationEvent(true));
                            } else {
                              context
                                  .read<AddLocationBloc>()
                                  .add(const ValidNameLocationEvent(false));
                            }
                          },
                          validator: (val) {
                            if (val!.length < 2) {
                              return "Not be less than 2 letters";
                            } else if (val.length > 12) {
                              return "Not be more than 12 letters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFieldCheckoutWidget(
                          formKey: fullAddress,
                          title: "Full Address",
                          color: Theme.of(context).colorScheme.surface,
                          controller: fullAddressController,
                          hintText: "please enter full address",
                          keyboardType: TextInputType.name,
                          onChanged: (_) {
                            if (fullAddress.currentState!.validate()) {
                              context.read<AddLocationBloc>().add(
                                  const ValidFullAddressLocationEvent(true));
                            } else {
                              context.read<AddLocationBloc>().add(
                                  const ValidFullAddressLocationEvent(false));
                            }
                          },
                          validator: (val) {
                            if (val!.length < 5) {
                              return "Not be less than 5 letters";
                            } else if (val.length > 50) {
                              return "Not be more than 50 letters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            BlocSelector<AddLocationBloc, AddLocationState,
                                bool>(
                              selector: (state) => state.isDefault,
                              builder: (context, isDefault) {
                                return Checkbox(
                                  activeColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  value: isDefault,
                                  onChanged: (val) {
                                    context
                                        .read<AddLocationBloc>()
                                        .add(DefaultLocationEvent(!val!));
                                  },
                                );
                              },
                            ),
                            Text(
                              "Make this as default card",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<AddLocationBloc, AddLocationState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: state.validAll
                                  ? () async {
                                      final user = await di
                                          .sl<CachedUserInfo>()
                                          .getUserInfo();
                                      final LocationEntity location =
                                          LocationEntity(
                                        locationID: 0,
                                        userID: user.userId!,
                                        latitude: state.latitude,
                                        longitude: state.longitude,
                                        addressName: addressNameController.text,
                                        fullAddress: fullAddressController.text,
                                        defultAddress: state.isDefault ? 1 : 0,
                                      );
                                      if (!context.mounted) return;
                                      context
                                          .read<AddLocationBloc>()
                                          .add(AddNewLocationEvent(location));
                                      context.pop();
                                    }
                                  : null,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  color: state.validAll
                                      ? Theme.of(context)
                                          .colorScheme
                                          .inversePrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add",
                                    style: state.validAll
                                        ? Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.all(30),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.6),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            child: const Center(
              child: Icon(Icons.add),
            ),
          )),
    );
  }
}
