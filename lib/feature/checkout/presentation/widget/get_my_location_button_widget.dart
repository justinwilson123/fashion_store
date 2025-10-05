import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/add_loaction/add_location_bloc.dart';

class GetMyLocationButtonWidget extends StatelessWidget {
  const GetMyLocationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: GestureDetector(
          onTap: () {
            context.read<AddLocationBloc>().add(const GetMyLocationEvent());
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
              child: Icon(Icons.my_location),
            ),
          )),
    );
  }
}
