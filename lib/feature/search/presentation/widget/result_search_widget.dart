import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fashion/core/function/translate_from_api.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/constant/name_app_route.dart';
import '../controller/controller/search_bloc.dart';

class ResultSearchWidget extends StatelessWidget {
  const ResultSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.nameProduct.isEmpty
            ? Container()
            : Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (_, _) => Divider(
                          color: Theme.of(context).colorScheme.surface,
                          thickness: 1,
                        ),
                        itemCount: state.fromNetwork.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 53,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                onTap: () {
                                  context.read<SearchBloc>().add(
                                    AddReusltToCachedEevent(
                                      state.fromNetwork[i],
                                    ),
                                  );
                                  final productEntity = ProductEntity(
                                    productId: state.fromNetwork[i].productId,
                                    productCategoryId:
                                        state.fromNetwork[i].productCategoryId,
                                    nameEn: state.fromNetwork[i].nameEn,
                                    nameAr: state.fromNetwork[i].nameAr,
                                    descriptionEn:
                                        state.fromNetwork[i].descriptionEn,
                                    descriptionAr:
                                        state.fromNetwork[i].descriptionAr,
                                    productPrice:
                                        state.fromNetwork[i].productPrice,
                                    productImage:
                                        state.fromNetwork[i].productImage,
                                    productDiscount:
                                        state.fromNetwork[i].productDiscount,
                                    productActive:
                                        state.fromNetwork[i].productActive,
                                    countRating:
                                        state.fromNetwork[i].countRating,
                                    avgRating: state.fromNetwork[i].avgRating,
                                    review: state.fromNetwork[i].review,
                                    favorite: state.fromNetwork[i].favorite,
                                  );
                                  context.pushNamed(
                                    NameAppRoute.productDetails,
                                    extra: productEntity,
                                    pathParameters: {"fromPage": "2"},
                                  );
                                },
                                title: Text(
                                  translateFromApi(
                                    context,
                                    state.fromNetwork[i].nameEn,
                                    state.fromNetwork[i].nameAr,
                                  ),
                                ),
                                leading: SizedBox(
                                  height: 53,
                                  width: 40,
                                  child: FancyShimmerImage(
                                    boxFit: BoxFit.fill,
                                    errorWidget: const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                    shimmerBaseColor: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    shimmerBackColor: Theme.of(
                                      context,
                                    ).colorScheme.secondaryContainer,
                                    imageUrl:
                                        "${AppLinks.productImageLink}/${state.fromNetwork[i].productImage}",
                                  ),
                                ),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          );
                        },
                      ),
              );
      },
    );
  }
}
