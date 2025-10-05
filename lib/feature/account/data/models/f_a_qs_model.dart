import 'package:fashion/feature/account/domain/entities/faqs_entity.dart';

class FAQsModel extends FAQsEntity {
  const FAQsModel({
    required super.faqsID,
    required super.topic,
    required super.question,
    required super.answer,
  });

  factory FAQsModel.fromJson(Map<String, dynamic> json) {
    return FAQsModel(
      faqsID: json['id'],
      topic: json['the_topic'],
      question: json['the_question'],
      answer: json['the_answer'],
    );
  }
}
