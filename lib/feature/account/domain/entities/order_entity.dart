import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int countItem;
  final int sumItems;
  final int productID;
  final int productPrice;
  final int userID;
  final String imageName;
  final String nameEn;
  final String nameAr;
  final int orderID;
  final String statusOrder;
  final int deliveryID;
  final int sizeID;
  final String sizedName;
  final int colorID;
  final String colorNameEn;
  final String colorNameAr;
  final String hexCodeColor;
  final int isRating;
  final int rating;
  final int locationID;

  const OrderEntity({
    required this.countItem,
    required this.sumItems,
    required this.productID,
    required this.productPrice,
    required this.userID,
    required this.imageName,
    required this.nameEn,
    required this.nameAr,
    required this.orderID,
    required this.statusOrder,
    required this.deliveryID,
    required this.sizeID,
    required this.sizedName,
    required this.colorID,
    required this.colorNameEn,
    required this.colorNameAr,
    required this.hexCodeColor,
    required this.isRating,
    required this.rating,
    required this.locationID,
  });

  OrderEntity copyWith({
    int? isRating,
    int? rating,
  }) {
    return OrderEntity(
      countItem: countItem,
      sumItems: sumItems,
      productID: productID,
      productPrice: productPrice,
      userID: userID,
      imageName: imageName,
      nameEn: nameEn,
      nameAr: nameAr,
      orderID: orderID,
      statusOrder: statusOrder,
      deliveryID: deliveryID,
      sizeID: sizeID,
      sizedName: sizedName,
      colorID: colorID,
      colorNameEn: colorNameEn,
      colorNameAr: colorNameAr,
      hexCodeColor: hexCodeColor,
      isRating: isRating ?? this.isRating,
      rating: rating ?? this.rating,
      locationID: locationID,
    );
  }

  @override
  List<Object?> get props => [
        countItem,
        sumItems,
        productID,
        productPrice,
        userID,
        imageName,
        nameEn,
        nameAr,
        orderID,
        statusOrder,
        deliveryID,
        sizedName,
        colorNameEn,
        colorNameAr,
        hexCodeColor,
        isRating,
        rating,
        locationID,
      ];
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