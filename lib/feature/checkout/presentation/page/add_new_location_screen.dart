import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../auth/presentation/widgets/show.dart';
import '../controller/add_loaction/add_location_bloc.dart';
import '../../../../injiction_container.dart' as di;
import '../controller/checkout/checkout_bloc.dart';
import '../widget/add_my_location_button_widget.dart';
import '../widget/get_my_location_button_widget.dart';
import '../widget/get_my_location_loading_widget.dart';
import '../widget/is_loading_widget.dart';

class AddNewLocationScreen extends StatelessWidget {
  AddNewLocationScreen({super.key});
  final MapController _map = di.sl<MapController>();
  final GlobalKey<FormState> _addressName = GlobalKey<FormState>();
  final GlobalKey<FormState> _fullAddress = GlobalKey<FormState>();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _fullAddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddLocationBloc, AddLocationState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            showSnacBarFun(context, state.errorMessage, Colors.redAccent);
          }
          if (state.successMessage.isNotEmpty) {
            _buildSeccessShowDialog(context);
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            context.read<CheckoutBloc>().add(const GetAllLocationEvent());
            return true;
          },
          child: Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.only(top: 20),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      TitlePageWidget(
                        title: "Add Location",
                        onPressed: () {
                          context
                              .read<CheckoutBloc>()
                              .add(const GetAllLocationEvent());
                          context.pop();
                        },
                      ),
                      BlocBuilder<AddLocationBloc, AddLocationState>(
                        builder: (context, state) {
                          return Expanded(
                              child: SizedBox(
                            child: FlutterMap(
                              mapController: _map,
                              options: MapOptions(
                                onTap: (tapposition, latLng) {
                                  context
                                      .read<AddLocationBloc>()
                                      .add(AddMarkerEvent(
                                        latLng.latitude,
                                        latLng.longitude,
                                      ));
                                },
                                initialCenter: const LatLng(40.730610,
                                    -73.935242), // Center the map over London
                                initialZoom: 6,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                                  userAgentPackageName:
                                      'com.example.fashion', // Add your app identifier
                                  // And many more recommended properties!
                                ),
                                MarkerLayer(markers: state.markers),
                                const GetMyLocationButtonWidget(),
                                AddMyLocationButtonWidget(
                                  addressName: _addressName,
                                  fullAddress: _fullAddress,
                                  addressNameController: _addressNameController,
                                  fullAddressController: _fullAddressController,
                                ),
                              ],
                            ),
                          ));
                        },
                      ),
                    ],
                  ),
                  const GetMyLocationLoadingWidget(),
                  const IsLoadingWidget(),
                ],
              ),
            ),
          ),
        ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Congratulations!",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your new location has been added.",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
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
                  )
                ],
              ),
            ),
          );
        });
  }
}
