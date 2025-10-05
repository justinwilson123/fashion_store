import 'package:fashion/feature/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.countItem,
    required super.sumPriceItem,
    required super.cartID,
    required super.productID,
    required super.productPrice,
    required super.cartUserID,
    required super.imageName,
    required super.nameEn,
    required super.nameAr,
    required super.sizeID,
    required super.colorID,
    required super.orderID,
    required super.cartDate,
    required super.sizeName,
    required super.colorNameAr,
    required super.colorNameEn,
    required super.hexCodeColor,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      countItem: json['countitem'],
      sumPriceItem: json['sum_items'],
      cartID: json['cart_id'],
      productID: json['cart_product_id'],
      productPrice: json['product_price'],
      cartUserID: json['cart_user_id'],
      imageName: json['item_image_name'],
      nameEn: json['product_name_en'],
      nameAr: json['product_name_ar'],
      sizeID: json['size_product_id'],
      colorID: json['color_product_id'],
      orderID: json['order_id'],
      cartDate: DateTime.parse(json['cart_date']),
      sizeName: json['sized_name'],
      colorNameAr: json['color_name_ar'],
      colorNameEn: json['color_name_en'],
      hexCodeColor: json['hex_code_color'],
    );
  }
}

// {
//             "countitem": 1,
//             "sum_items": 1350,
//             "cart_id": 110,
//             "cart_product_id": 26,
//             "product_price": 1350,
//             "cart_user_id": 12,
//             "item_image_name": "adidas2.png",
//             "product_name_ar": "أديداس بقصة عادية",
//             "product_name_en": "Regular Fit Adidas",
//             "size_product_id": 1,
//             "color_product_id": 4,
//             "order_id": 0,
//             "status_order": "Packing",
//             "deliver_id": 0,
//             "cart_date": "2025-08-01 09:57:00",
//             "sized_name": "S",
//             "color_name_en": "white",
//             "color_name_ar": "أبيض",
//             "hex_code_color": "#FFFFFF"
//         }

