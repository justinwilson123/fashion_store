import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/account/domain/entities/order_entity.dart';
import 'package:fashion/feature/account/presentation/controller/track_order/track_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../injiction_container.dart' as di;

class TrakckingOrderPage extends StatelessWidget {
  TrakckingOrderPage({super.key, required this.order});
  final MapController _map = di.sl<MapController>();
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    int currentStep = _currentStep(order.statusOrder);
    context.read<TrackOrderBloc>().add(GetMyLocationEvent(order.locationID));
    order.statusOrder == "InTransit"
        ? context
            .read<TrackOrderBloc>()
            .add(GetDeliveryDetailsEvent(order.deliveryID))
        : null;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(
            children: [
              TitlePageWidget(
                title: "Track Order",
                onPressed: () {
                  context.pop();
                },
              ),
              Expanded(child: SizedBox(
                child: BlocBuilder<TrackOrderBloc, TrackOrderState>(
                  builder: (context, state) {
                    return state.loadingMap
                        ? const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Download Map"),
                                SizedBox(width: 20),
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                        : FlutterMap(
                            mapController: _map,
                            options: MapOptions(
                              onTap: (tapposition, latLng) {},
                              initialCenter: LatLng(
                                  state.myLocation["latitude"],
                                  state.myLocation[
                                      "longitude"]), // Center the map over London
                              initialZoom: 14,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                                userAgentPackageName: 'com.example.fashion',
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                  point: LatLng(state.myLocation["latitude"],
                                      state.myLocation["longitude"]),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black,
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                    onTap: () {
                                      _buildDetails(context, currentStep);
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.delivery_dining),
                                      ),
                                    )),
                              )
                            ],
                          );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  int _currentStep(String status) {
    return status == "Packing"
        ? 0
        : status == "Packed"
            ? 1
            : status == "InTransit"
                ? 2
                : 3;
  }

  PersistentBottomSheetController _buildDetails(
    BuildContext context,
    int currentStep,
  ) {
    return showBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      context: context,
      builder: (_) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 8.0, right: 20, left: 20, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 6,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Status",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Stepper(
                stepIconBuilder: (i, state) {
                  return i <= currentStep
                      ? const Icon(Icons.radio_button_checked)
                      : const Icon(
                          Icons.radio_button_off_outlined,
                          color: Colors.grey,
                        );
                },
                connectorThickness: 2,
                stepIconMargin: const EdgeInsets.all(0),
                controlsBuilder: (context, details) {
                  return Container();
                },
                currentStep: currentStep,
                steps: <Step>[
                  Step(
                    title: const Text("Packing"),
                    content: const SizedBox(),
                    stepStyle: const StepStyle(
                      color: Colors.white,
                    ),
                    isActive: currentStep >= 0 ? true : false,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text("packed"),
                    content: const SizedBox(),
                    isActive: currentStep >= 1 ? true : false,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                    stepStyle: const StepStyle(
                      color: Colors.white,
                    ),
                  ),
                  Step(
                    title: const Text("In Transit"),
                    content: const SizedBox(),
                    isActive: currentStep >= 2 ? true : false,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                    stepStyle: const StepStyle(
                      color: Colors.white,
                    ),
                  ),
                  Step(
                    title: const Text("Delivered"),
                    content: const SizedBox(),
                    isActive: currentStep >= 3 ? true : false,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                    stepStyle: const StepStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              order.statusOrder == "InTransit"
                  ? BlocSelector<TrackOrderBloc, TrackOrderState, Map>(
                      selector: (state) => state.delivery,
                      builder: (context, delivery) {
                        return delivery.isNotEmpty
                            ? ListTile(
                                title: Text(delivery["delivery_full_name"]),
                                subtitle: Text(
                                  "Delivery Guy",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                trailing: ClipOval(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final Uri launchUri = Uri(
                                        scheme: 'tel',
                                        path: delivery["delivery_phone"],
                                      );
                                      await launchUrl(launchUri);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      child: Center(child: Icon(Icons.phone)),
                                    ),
                                  ),
                                ),
                                leading: ClipOval(
                                    child: Image.network(
                                  AppLinks.deliveryImage +
                                      delivery["delivery_image"],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )),
                              )
                            : SizedBox();
                      },
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
