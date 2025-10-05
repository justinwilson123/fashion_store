import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int countItem;
  final int sumPriceItem;
  final int cartID;
  final int productID;
  final int productPrice;
  final int cartUserID;
  final String imageName;
  final String nameEn;
  final String nameAr;
  final int sizeID;
  final int colorID;
  final int orderID;
  final DateTime cartDate;
  final String sizeName;
  final String colorNameAr;
  final String colorNameEn;
  final String hexCodeColor;

  const CartEntity({
    required this.countItem,
    required this.sumPriceItem,
    required this.cartID,
    required this.productID,
    required this.productPrice,
    required this.cartUserID,
    required this.imageName,
    required this.nameEn,
    required this.nameAr,
    required this.sizeID,
    required this.colorID,
    required this.orderID,
    required this.cartDate,
    required this.sizeName,
    required this.colorNameAr,
    required this.colorNameEn,
    required this.hexCodeColor,
  });

  CartEntity copyWith({
    int? countItem,
    int? sumPriceItem,
    int? cartID,
    int? productID,
    int? productPrice,
    int? cartUserID,
    String? imageName,
    String? nameEn,
    String? nameAr,
    int? sizeID,
    int? colorID,
    int? orderID,
    DateTime? cartDate,
    String? sizeName,
    String? colorNameAr,
    String? colorNameEn,
    String? hexCodeColor,
  }) {
    return CartEntity(
      countItem: countItem ?? this.countItem,
      sumPriceItem: sumPriceItem ?? this.sumPriceItem,
      cartID: cartID ?? this.cartID,
      productID: productID ?? this.productID,
      productPrice: productPrice ?? this.productPrice,
      cartUserID: cartUserID ?? this.cartUserID,
      imageName: imageName ?? this.imageName,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      sizeID: sizeID ?? this.sizeID,
      colorID: colorID ?? this.colorID,
      orderID: orderID ?? this.orderID,
      cartDate: cartDate ?? this.cartDate,
      sizeName: sizeName ?? this.sizeName,
      colorNameAr: colorNameAr ?? this.colorNameAr,
      colorNameEn: colorNameEn ?? this.colorNameEn,
      hexCodeColor: hexCodeColor ?? this.hexCodeColor,
    );
  }

  @override
  List<Object?> get props => [
    countItem,
    sumPriceItem,
    cartID,
    productID,
    productPrice,
    cartUserID,
    imageName,
    nameEn,
    nameAr,
    sizeID,
    colorID,
    orderID,
    cartDate,
    sizeName,
    colorNameAr,
    colorNameEn,
    hexCodeColor,
  ];
}

// {
//             "countitem": 1,
//             "sum item": 1190,
//             "cart_id": 3,
//             "cart_product_id": 3,
//             "product_price": 1190,
//             "cart_user_id": 1,
//             "item_image_name": "slogan.png",
//             "product_name_ar": "شعار المقاس العادي",
//             "product_name_en": "Regular Fit Slogan",
//             "size_product_id": 3,
//             "color_product_id": 2,
//             "oder_id": 0,
//             "cart_date": "2025-07-07 14:04:24",
//             "sized_name": "L",
//             "color_name_en": "Turquoise",
//             "color_name_ar": "فيروزي",
//             "hex_code_color": "#0490A5"
//         }
