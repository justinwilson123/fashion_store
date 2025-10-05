import 'package:fashion/core/class/app_localization.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/function/translate_from_api.dart';
import 'package:fashion/core/widget/empty_page_widget.dart';
import 'package:fashion/feature/home/presentation/controller/controller/home_bloc_bloc.dart';
import 'package:fashion/feature/home/presentation/widget/button_selector_widget.dart';
import 'package:fashion/feature/home/presentation/widget/product_widget.dart';
import 'package:fashion/feature/home/presentation/widget/shimmer_categories.dart';
import 'package:fashion/feature/home/presentation/widget/shimmer_product.dart';
import 'package:fashion/feature/saved/presentation/controller/controller/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widget/notification_icon_button.dart';
import '../../../auth/presentation/widgets/show_sncak_bar_widget.dart';
import '../widget/shimmer_product_empty.dart';
import '../widget/show_filter_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _allProducController = ScrollController();
  final ScrollController _producController = ScrollController();
  double _lastScrollPosition = 0.0;
  bool _isScrollingDown = false;
  @override
  void initState() {
    _allProducController.addListener(_onScroll1);
    _producController.addListener(_onScroll2);
    super.initState();
  }

  void _onScroll1() {
    final maxScroll = _allProducController.position.maxScrollExtent;
    final currentScroll = _allProducController.offset;
    if (_allProducController.position.pixels > _lastScrollPosition) {
      // السكرول للأسفل
      if (!_isScrollingDown) {
        _isScrollingDown = true;
        context.read<HomeBloc>().add(const ShowAndHideAppBar(false));
      }
    } else if (_allProducController.position.pixels < _lastScrollPosition) {
      // السكرول للأعلى
      if (_isScrollingDown) {
        _isScrollingDown = false;
        context.read<HomeBloc>().add(const ShowAndHideAppBar(true));
      }
    }
    if (currentScroll >= (maxScroll * 0.8)) {
      context.read<HomeBloc>().add(const GetAllProductEvent());
    }
    _lastScrollPosition = _allProducController.position.pixels;
  }

  void _onScroll2() {
    final maxScroll = _producController.position.maxScrollExtent;
    final currentScroll = _producController.offset;
    if (_producController.position.pixels > _lastScrollPosition) {
      // السكرول للأسفل
      if (!_isScrollingDown) {
        _isScrollingDown = true;
        context.read<HomeBloc>().add(const ShowAndHideAppBar(false));
      }
    } else if (_producController.position.pixels < _lastScrollPosition) {
      // السكرول للأعلى
      if (_isScrollingDown) {
        _isScrollingDown = false;
        context.read<HomeBloc>().add(const ShowAndHideAppBar(true));
      }
    }
    if (currentScroll >= (maxScroll * 0.8)) {
      context.read<HomeBloc>().add(const GetProductEvent());
    }
    _lastScrollPosition = _producController.position.pixels;
  }

  @override
  void dispose() {
    _allProducController
      ..removeListener(_onScroll1)
      ..dispose();
    _producController
      ..removeListener(_onScroll1)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filter = ["Relevance", "Price: Low-High", "Price: High-Low"];
    return Scaffold(
      body: BlocListener<HomeBloc, HomeBlocState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            showSnacBarFun(
              context,
              state.errorMessage.tr(context),
              Colors.redAccent,
            );
          }
        },
        child: BlocListener<SavedBloc, SavedState>(
          listener: (context, state) {
            if (state.successMessage.isNotEmpty) {
              showSnacBarFun(context, state.successMessage, Colors.greenAccent);
            }
            if (state.errorMessage.isNotEmpty) {
              showSnacBarFun(
                context,
                state.errorMessage.tr(context),
                Colors.redAccent,
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _title(context),
                  _showAndHideSearchAndCatergories(filter),
                  _buidProduct(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocSelector<HomeBloc, HomeBlocState, bool> _showAndHideSearchAndCatergories(
    List<String> filter,
  ) {
    return BlocSelector<HomeBloc, HomeBlocState, bool>(
      selector: (state) => state.showHide,
      builder: (context, showHide) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: showHide ? 132 : 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (showHide)
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 250)),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.done)
                        ? _searchAndFilter(context, filter)
                        : const SizedBox();
                  },
                ),
              if (showHide)
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 500)),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.done)
                        ? _categories()
                        : const SizedBox();
                  },
                ),
              // _searchAndFilter(context, filter),
              // _categories(),
            ],
          ),
        );
      },
    );
  }

  Expanded _buidProduct() {
    return Expanded(
      child: BlocBuilder<HomeBloc, HomeBlocState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.initiIndex == 0 ? 0 : 1,
            children: [allProduct(state, context), _prodct(state, context)],
          );
        },
      ),
    );
  }

  Widget allProduct(HomeBlocState state, BuildContext context) {
    return state.allProduct.isEmpty && !state.isAllProductLoading
        ? EmptyPageWidget(
            icon: Icons.inbox_outlined,
            title: "Empty Category",
            subTitle: "Not found Any Item yet,you will add it rearly",
            onPressed: () {},
          )
        : state.allProduct.isEmpty && state.isAllProductLoading
        ? const ShimmgerProductEmpty()
        : state.allProduct.isNotEmpty
        ? GridView.builder(
            controller: _allProducController,
            itemCount: state.isAllProductLoading
                ? state.allProduct.length + 2
                : state.allProduct.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              context.read<SavedBloc>().add(
                AddToMapSavedEvent(state.savedProduct),
              );
              if (index >= state.allProduct.length) {
                return const ShimmerProduct();
              }

              return ProductWidget(
                url:
                    "${AppLinks.productImageLink}${state.allProduct[index].productImage}",
                onTap: () {
                  context.pushNamed(
                    NameAppRoute.productDetails,
                    extra: state.allProduct[index],
                    pathParameters: {"fromPage": "0"},
                  );
                },
                productName: translateFromApi(
                  context,
                  state.allProduct[index].nameEn,
                  state.allProduct[index].nameAr,
                ),
                productPrice: state.allProduct[index].productPrice,
                productID: state.allProduct[index].productId,
              );
            },
          )
        // )
        : Container();
  }

  Widget _prodct(HomeBlocState state, BuildContext context) {
    return state.product.isEmpty && !state.isProductLoading
        ? EmptyPageWidget(
            icon: Icons.inbox_outlined,
            title: "Empty Category",
            subTitle: "Not found Any Item yet,you will add it rearly",
            onPressed: () {},
          )
        : state.product.isEmpty && state.isProductLoading
        ? const ShimmgerProductEmpty()
        : state.product.isNotEmpty
        ? GridView.builder(
            controller: _producController,
            itemCount: state.isProductLoading
                ? state.product.length + 2
                : state.product.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              context.read<SavedBloc>().add(
                AddToMapSavedEvent(state.savedProduct),
              );
              if (index >= state.product.length) {
                return const ShimmerProduct();
              }

              return ProductWidget(
                url:
                    "${AppLinks.productImageLink}${state.product[index].productImage}",
                onTap: () {
                  context.pushNamed(
                    NameAppRoute.productDetails,
                    extra: state.product[index],
                    pathParameters: {"fromPage": "0"},
                  );
                },
                productName: translateFromApi(
                  context,
                  state.product[index].nameEn,
                  state.product[index].nameAr,
                ),
                productPrice: state.product[index].productPrice,
                productID: state.product[index].productId,
              );
            },
          )
        : Container();
  }

  SizedBox _searchAndFilter(BuildContext context, List<String> filter) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.goNamed(NameAppRoute.search);
              },
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "search for clothes...",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                    Icon(
                      Icons.mic_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer,
                  showDragHandle: true,
                  context: context,
                  builder: (_) {
                    return ShowFilterWidget(filter: filter);
                  },
                );
              },
              child: Image.asset(
                height: 24,
                width: 24,
                "assets/image/Filter.png",
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _categories() {
    return SizedBox(
      height: 40,
      child: BlocBuilder<HomeBloc, HomeBlocState>(
        builder: (context, state) {
          if (state.isCategoriesLoading) {
            return const ShimmerCategories();
          } else if (state.categories.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length + 1,
              itemBuilder: (context, index) {
                return ButtonSelectorWidget(
                  onTap: () {
                    if (index == 0) {
                      if (index == state.initiIndex &&
                          state.allProduct.isNotEmpty) {
                        _allProducController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      }
                      context.read<HomeBloc>().add(
                        ChooseGategoryEvent(index, state.categoryID),
                      );
                    } else {
                      if (index == state.initiIndex &&
                          state.product.isNotEmpty) {
                        _producController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      } else {
                        if (state.isProductLoading) return;

                        if (state.categoryID ==
                            state.categories[index - 1].categoryId) {
                          context.read<HomeBloc>().add(
                            ChooseGategoryEvent(index, state.categoryID),
                          );
                        } else {
                          context.read<HomeBloc>().add(
                            ChooseGategoryEvent(
                              index,
                              state.categories[index - 1].categoryId,
                            ),
                          );
                          context.read<HomeBloc>().add(const GetProductEvent());
                        }
                      }
                    }
                  },
                  colorSelectedContainer: state.initiIndex == index,
                  text: index == 0
                      ? "47".tr(context)
                      : translateFromApi(
                          context,
                          state.categories[index - 1].categoryNameEn,
                          state.categories[index - 1].categoryNameAr,
                        ),
                  colorSelectedText: state.initiIndex == index,
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Container _title(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Discover", style: Theme.of(context).textTheme.displayLarge),
          const NotificationIconButton(),
        ],
      ),
    );
  }
}
