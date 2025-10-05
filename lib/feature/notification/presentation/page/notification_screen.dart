import 'package:fashion/core/class/app_localization.dart';
import 'package:fashion/core/widget/title_page_widget.dart';
import 'package:fashion/feature/auth/presentation/widgets/show_sncak_bar_widget.dart';
import 'package:fashion/feature/notification/presentation/controller/controller/notification_bloc.dart';
import 'package:fashion/feature/notification/presentation/widget/loading_more_notification_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/empty_page_widget.dart';
import '../widget/loading_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(const GetNotificationEvent());
    return WillPopScope(
      onWillPop: () async {
        context.read<NotificationBloc>().add(const ReadAllNotificationEvent());
        return true;
      },
      child: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              TitlePageWidget(
                title: "Notification",
                onPressed: () {
                  context
                      .read<NotificationBloc>()
                      .add(const ReadAllNotificationEvent());
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: BlocConsumer<NotificationBloc, NotificationState>(
                    listener: (context, state) {
                  if (state.errorMessage.isNotEmpty) {
                    showSnacBarFun(
                      context,
                      state.errorMessage.tr(context),
                      Colors.redAccent,
                    );
                  }
                }, builder: (context, state) {
                  if (state.isLoading && state.notification.isEmpty) {
                    return const LoadingNotification();
                  } else if (state.notification.isEmpty && !state.isLoading) {
                    return EmptyPageWidget(
                      icon: Icons.notifications_outlined,
                      title: "You haven’t gotten any notifications yet!",
                      subTitle: "We’ll alert you when something cool happens.",
                      onPressed: () {},
                    );
                  } else if (state.notification.isNotEmpty) {
                    return _buildNotificationsList(context, state);
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
      BuildContext context, NotificationState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrllInfo) {
        if (scrllInfo.metrics.pixels == scrllInfo.metrics.maxScrollExtent) {
          context.read<NotificationBloc>().add(const GetNotificationEvent());
        }
        return true;
      },
      child: ListView.separated(
        separatorBuilder: (context, i) => Divider(
          height: 20,
          color: Theme.of(context).colorScheme.surface,
        ),
        itemCount: state.isLoading
            ? state.notification.length + 10
            : state.notification.length,
        itemBuilder: (context, index) {
          if (index >= state.notification.length) {
            return const LoadingMoreNotificationShimmer();
          }
          final group = state.notification[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  group.title == "Today"
                      ? group.title.tr(context)
                      : group.title == "Yesterday"
                          ? group.title.tr(context)
                          : group.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              ...group.notifications.map((notification) => Card(
                    color: notification.isRead == 0
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.secondaryContainer,
                    child: ListTile(
                      leading: _buildLeading(notification.type),
                      title: Text(
                        notification.title,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      subtitle: Text(
                        notification.body,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLeading(String type) {
    return type == "account"
        ? const Icon(Icons.person_2_outlined)
        : type == "offer"
            ? const Icon(Icons.discount_outlined)
            : type == "paymante"
                ? const Icon(Icons.payment_outlined)
                : type == "wallet"
                    ? const Icon(Icons.wallet_outlined)
                    : const Icon(Icons.location_on_outlined);
  }
}
