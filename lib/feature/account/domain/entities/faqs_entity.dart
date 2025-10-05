import 'package:equatable/equatable.dart';

class FAQsEntity extends Equatable {
  final int faqsID;
  final String topic;
  final String question;
  final String answer;

  const FAQsEntity({
    required this.faqsID,
    required this.topic,
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [
        faqsID,
        topic,
        question,
        answer,
      ];
}

// {
//             "id": 6,
//             "the_topic": "Account",
//             "the_question": "How do I create an account?",
//             "the_answer": "you can create your account use to email and password or google account or facebook account\r\n"
//         }