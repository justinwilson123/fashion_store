import 'package:flutter/material.dart';

import '../../../domain/entities/faqs_entity.dart';

class ListFaqsTopicWidget extends StatelessWidget {
  const ListFaqsTopicWidget({super.key, required this.fAQs});
  final List<FAQsEntity> fAQs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, i) => const SizedBox(height: 20),
        itemCount: fAQs.length,
        itemBuilder: (constext, i) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              shape: Border.all(style: BorderStyle.none),
              collapsedShape: Border.all(style: BorderStyle.none),
              title: Text(fAQs[i].question),
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      fAQs[i].answer,
                      style: Theme.of(context).textTheme.headlineMedium,
                    )),
              ],
            ),
          );
        });
  }
}
