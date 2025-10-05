import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/controller/home_bloc_bloc.dart';
import 'button_selector_widget.dart';
import 'range_price_widget.dart';

class ShowFilterWidget extends StatelessWidget {
  final List<String> filter;
  const ShowFilterWidget({
    required this.filter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<HomeBloc, HomeBlocState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleAndCancel(context),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(
                height: 5,
              ),
              _sortBy(context, state),
              Divider(
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(
                height: 10,
              ),
              state.initiIndexFilter == 0
                  ? RangePriceWidget(
                      onChanged: (RangeValues values) {
                        context.read<HomeBloc>().add(RangeSliderFilterEvent(
                              values.start,
                              values.end,
                            ));
                      },
                      min: state.startePrice.toDouble(),
                      max: state.endPrice.toDouble(),
                      titleStart: state.rangeValueStart.round().toString(),
                      titleEnd: state.rangeValueEnd.round().toString(),
                      values: RangeValues(
                        state.rangeValueStart,
                        state.rangeValueEnd,
                      ),
                    )
                  : const SizedBox(),
              const Spacer(),
              _buttonApplayFilter(context)
            ],
          );
        },
      ),
    );
  }

  GestureDetector _buttonApplayFilter(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeBloc>().add(const ApplayFilterEvnet());
        Navigator.of(context).pop();
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Center(
          child: Text(
            "Applay Filter",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }

  Column _sortBy(BuildContext context, HomeBlocState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Sort By",
        style: Theme.of(context).textTheme.displayMedium,
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 5),
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filter.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return ButtonSelectorWidget(
              onTap: () {
                context.read<HomeBloc>().add(ChooseFilterTypeEvent(index));
              },
              colorSelectedContainer: state.initiIndexFilter == index,
              text: filter[index],
              colorSelectedText: state.initiIndexFilter == index,
            );
          },
        ),
      ),
    ]);
  }

  SizedBox _titleAndCancel(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(
            "Filter",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}
