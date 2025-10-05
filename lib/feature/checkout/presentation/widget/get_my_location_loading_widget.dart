import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../controller/add_loaction/add_location_bloc.dart';

class GetMyLocationLoadingWidget extends StatelessWidget {
  const GetMyLocationLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddLocationBloc, AddLocationState, bool>(
      selector: (state) => state.getMyLocationLoading,
      builder: (context, isLoading) {
        return isLoading
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/getmylocation.json",
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
