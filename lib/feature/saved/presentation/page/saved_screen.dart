import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/feature/saved/presentation/controller/controller/saved_bloc.dart';
import 'package:fashion/feature/saved/presentation/widget/shimmer_saved_product_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_links.dart';
import '../../../../core/function/translate_from_api.dart';
import '../../../../core/widget/empty_page_widget.dart';
import '../../../../core/widget/title_page_widget.dart';
import '../widget/saved_product_widget.dart';
import '../widget/shimmer_saved_product.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SavedBloc>().add(const GetAllSavedProdutEvent());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            TitlePageWidget(
              title: "saved",
              onPressed: () => context.goNamed(NameAppRoute.home),
            ),
            Expanded(
              child: BlocBuilder<SavedBloc, SavedState>(
                builder: (context, state) {
                  if (state.product.isEmpty && !state.isLoading) {
                    return EmptyPageWidget(
                      icon: Icons.favorite_outline,
                      title: "No Saved Items!",
                      subTitle:
                          "You don’t have any saved items. Go to home and add some.",
                      onPressed: () => context
                          .read<SavedBloc>()
                          .add(const RefreshSavedProductEvent()),
                    );
                  } else if (state.isLoading && state.product.isEmpty) {
                    return const ShimmerSavedProductEmpty();
                  } else if (state.product.isNotEmpty) {
                    return _builSavedProduct(context, state);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  NotificationListener<ScrollNotification> _builSavedProduct(
      BuildContext context, SavedState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrllInfo) {
        if (scrllInfo.metrics.pixels == scrllInfo.metrics.maxScrollExtent) {
          context.read<SavedBloc>().add(const GetAllSavedProdutEvent());
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<SavedBloc>().add(const RefreshSavedProductEvent());
        },
        child: GridView.builder(
          itemCount:
              state.isLoading ? state.product.length + 2 : state.product.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            if (index >= state.product.length) {
              return const ShimmerSavedProduct();
            }

            return SavedProductWidget(
              url:
                  "${AppLinks.productImageLink}${state.product[index].productImage}",
              savedProductEntity: state.product[index],
              productName: translateFromApi(
                context,
                state.product[index].nameEn,
                state.product[index].nameAr,
              ),
              productPrice: state.product[index].productPrice,
              productID: state.product[index].productId,
            );
          },
        ),
      ),
    );
  }

  // Expanded _buildNoItem(BuildContext context) {
  //   return Expanded(
  //     child: Column(children: [
  //       Divider(
  //         color: Theme.of(context).colorScheme.surface,
  //       ),
  //       Expanded(
  //         child: Center(
  //           child: SizedBox(
  //             height: 160,
  //             width: 252,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Icon(
  //                   Icons.favorite_outline,
  //                   size: 50,
  //                   color: Theme.of(context).colorScheme.surface,
  //                 ),
  //                 Text(
  //                   "No Saved Items!",
  //                   style: Theme.of(context).textTheme.displayLarge,
  //                 ),
  //                 Text(
  //                   textAlign: TextAlign.center,
  //                   "You don’t have any saved items. Go to home and add some.",
  //                   style: Theme.of(context).textTheme.headlineMedium,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       IconButton(
  //         onPressed: () {
  //           context.read<SavedBloc>().add(const RefreshSavedProductEvent());
  //         },
  //         icon: const Icon(Icons.refresh),
  //       ),
  //     ]),
  //   );
  // }

//   Padding _buildTitle(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: Row(
//         textDirection: TextDirection.rtl,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const NotificationIconButton(),
//           Text(
//             "Saved",
//             style: Theme.of(context).textTheme.displayLarge,
//           ),
//           Directionality(
//             textDirection: TextDirection.ltr,
//             child: IconButton(
//               onPressed: () {
//                 context.goNamed(NameAppRoute.home);
//               },
//               icon: const Icon(Icons.arrow_back),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
