import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feature/notification/presentation/controller/controller/notification_bloc.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotificationBloc, NotificationState, int>(
      selector: (state) => state.nummberNotRead,
      builder: (context, notRead) {
        return IconButton(
            onPressed: () async {
              context.go("/home/notification");
            },
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                notRead == 0
                    ? const SizedBox()
                    : Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      )
              ],
            ));
      },
    );
  }
}
