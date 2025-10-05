import 'package:fashion/feature/account/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.countItem,
    required super.sumItems,
    required super.productID,
    required super.productPrice,
    required super.userID,
    required super.imageName,
    required super.nameEn,
    required super.nameAr,
    required super.orderID,
    required super.statusOrder,
    required super.deliveryID,
    required super.sizeID,
    required super.sizedName,
    required super.colorID,
    required super.colorNameEn,
    required super.colorNameAr,
    required super.hexCodeColor,
    required super.isRating,
    required super.rating,
    required super.locationID,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      countItem: json['countitem'],
      sumItems: json['sum_items'],
      productID: json['cart_product_id'],
      productPrice: json['product_price'],
      userID: json['cart_user_id'],
      imageName: json['item_image_name'],
      nameEn: json['product_name_en'],
      nameAr: json['product_name_ar'],
      orderID: json['order_id'],
      statusOrder: json['status_order'],
      deliveryID: json['deliver_id'],
      sizeID: json['size_product_id'],
      sizedName: json['sized_name'],
      colorID: json['color_product_id'],
      colorNameEn: json['color_name_en'],
      colorNameAr: json['color_name_ar'],
      hexCodeColor: json['hex_code_color'],
      isRating: json['is_rating'],
      rating: json['rating'],
      locationID: json['location_ID'],
    );
  }
}

// {
//             "countitem": 1,
//             "sum_items": 1350,
//             "cart_id": 138,
//             "cart_product_id": 32,
//             "product_price": 1350,
//             "cart_user_id": 12,
//             "item_image_name": "adidas3.png",
//             "product_name_ar": "أديداس بقصة عادية",
//             "product_name_en": "Regular Fit Adidas",
//             "size_product_id": 1,
//             "color_product_id": 4,
//             "order_id": 34,
//             "status_order": "completed",
//             "deliver_id": 0,
//             "cart_date": "2025-08-01 14:38:00",
//             "sized_name": "S",
//             "color_name_en": "white",
//             "color_name_ar": "أبيض",
//             "hex_code_color": "#FFFFFF"
//         }