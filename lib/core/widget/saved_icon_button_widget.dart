import 'package:fashion/feature/saved/presentation/controller/controller/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/home/presentation/controller/controller/home_bloc_bloc.dart';

class SavedIconButtonWidget extends StatelessWidget {
  final int productID;
  const SavedIconButtonWidget({
    super.key,
    required this.productID,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SavedBloc, SavedState, Map>(
      selector: (state) => state.savedProduct,
      builder: (context, savedProduct) {
        return Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {
                  if (savedProduct[productID] == 0) {
                    context
                        .read<SavedBloc>()
                        .add(AddToSavedProductEvent(productID));
                    context
                        .read<HomeBloc>()
                        .add(AddRemoveFromMapSavedProductEvent(productID, 1));
                  } else {
                    context
                        .read<SavedBloc>()
                        .add(RemoveFromSavedProductEvent(productID));
                    context
                        .read<HomeBloc>()
                        .add(AddRemoveFromMapSavedProductEvent(productID, 0));
                  }
                },
                icon: savedProduct[productID] == 1
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                      )));
      },
      // ),
    );
  }
}
