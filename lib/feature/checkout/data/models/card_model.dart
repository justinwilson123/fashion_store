import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';

class CardModel extends CardEntity {
  const CardModel({
    required super.id,
    required super.userID,
    required super.paymentMethod,
    required super.cardLast4,
    required super.cardBrand,
    required super.isDefault,
  });
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      userID: json['card_user_id'],
      paymentMethod: json['payment_method_id'],
      cardLast4: json['card_last4'],
      cardBrand: json['card_brand'],
      isDefault: json['is_default'],
    );
  }
// {
//         "id": 1,
//         "card_user_id": 1,
//         "payment_method_id": "pm_123abc",
//         "card_last4": "4654",
//         "card_brand": "visa",
//         "is_default": 1
//     }
  Map<String, dynamic> toJson() {
    return {
      "userID": userID.toString(),
      "paymentMethodID": paymentMethod,
      "cardLast4": cardLast4,
      "cardBrand": cardBrand,
      "isDefault": isDefault.toString(),
    };
  }
}
