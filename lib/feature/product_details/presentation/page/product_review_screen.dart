import 'package:fashion/core/widget/empty_page_widget.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/product_details/presentation/controller/reviews/reviews_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/function/format_comment_time.dart';
import '../widget/shimmer_reviews.dart';

class ProductReviewScreen extends StatelessWidget {
  final ProductEntity productEntiti;
  const ProductReviewScreen({super.key, required this.productEntiti});

  @override
  Widget build(BuildContext context) {
    context.read<ReviewsBloc>().add(
      GetCountGroupByRatingEvent(productEntiti.productId),
    );
    context.read<ReviewsBloc>().add(GetReviewsEvent(productEntiti.productId));
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitlePageWidget(
                title: "Reviews",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(color: Theme.of(context).colorScheme.surface),
              _buildAvgRating(context),
              _buildDetailsRating(context),
              const SizedBox(height: 10),
              Divider(color: Theme.of(context).colorScheme.surface),
              const SizedBox(height: 10),
              Text(
                "${productEntiti.review} Reviews",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              _buildStateRevies(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildStateRevies() {
    return Expanded(
      child: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (context, state) {
          return state.isReviewsLoading && state.reviews.isEmpty
              ? const ShimmerReviews()
              : !state.isReviewsLoading && state.reviews.isEmpty
              ? const EmptyPageWidget(
                  icon: Icons.reviews_outlined,
                  title: "Empyt Reviews",
                  subTitle:
                      "Not found any reviews yet you can rating product when buy it",
                  showRefreshButton: false,
                )
              : state.reviews.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrllInfo) {
                    if (scrllInfo.metrics.pixels ==
                        scrllInfo.metrics.maxScrollExtent) {
                      context.read<ReviewsBloc>().add(
                        GetReviewsEvent(productEntiti.productId),
                      );
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: state.isReviewsLoading
                        ? state.reviews.length + 1
                        : state.reviews.length,
                    itemBuilder: (context, index) {
                      if (index >= state.reviews.length) {
                        return const ShimmerReviews();
                      }
                      return _buildReviews(state, index, context);
                    },
                  ),
                )
              : Container();
        },
      ),
    );
  }

  Column _buildReviews(ReviewsState state, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 13,
          child: Row(
            children: List.generate(5, (i) {
              return state.reviews[index].rating <= i
                  ? Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.surface,
                      size: 16,
                    )
                  : const Icon(Icons.star, color: Colors.yellow, size: 16);
            }),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          state.reviews[index].comment,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              state.reviews[index].userName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: 5),
            Text(
              formatCommentTime(context, state.reviews[index].time),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Divider(color: Theme.of(context).colorScheme.surface),
        const SizedBox(height: 10),
      ],
    );
  }

  Column _buildDetailsRating(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              SizedBox(
                height: 16,
                child: Row(
                  children: List.generate(5, (i) {
                    return index >= 4 - i + 1
                        ? Icon(
                            Icons.star,
                            size: 18,
                            color: Theme.of(context).colorScheme.surface,
                          )
                        : const Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.yellow,
                          );
                  }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BlocSelector<ReviewsBloc, ReviewsState, Map>(
                  selector: (state) => state.countGroupRating,
                  builder: (context, countGroupRating) {
                    return countGroupRating.isEmpty
                        ? LinearProgressIndicator(
                            minHeight: 5,
                            value: 0.0,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(4),
                          )
                        : LinearProgressIndicator(
                            minHeight: 5,
                            value: countGroupRating[4 - index + 1] != null
                                ? countGroupRating[4 - index + 1] /
                                      productEntiti.countRating
                                : 0.0,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(4),
                          );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Container _buildAvgRating(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 61,
      child: Row(
        children: [
          SizedBox(
            width: 84,
            child: FittedBox(
              child: Text(
                productEntiti.avgRating,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (_, i) => const SizedBox(width: 3),
                  itemBuilder: (context, index) {
                    final avgRating = double.parse(
                      productEntiti.avgRating,
                    ).round();
                    return avgRating <= index
                        ? Icon(
                            Icons.star,
                            size: 22,
                            color: Theme.of(context).colorScheme.surface,
                          )
                        : const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 22,
                          );
                  },
                ),
              ),
              Text(
                "${productEntiti.countRating} Ratings",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
