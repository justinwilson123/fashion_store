import 'package:fashion/feature/product_details/domain/entity/details_entities.dart';

class ColorsModel extends ColorsEntity {
  const ColorsModel({
    required super.colorNameEn,
    required super.colorNameAr,
    required super.hexCodeColor,
    required super.colorID,
  });

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      colorNameEn: json['color_name_en'],
      colorNameAr: json['color_name_ar'],
      hexCodeColor: json['hex_code_color'],
      colorID: json['colors_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "color_name_en": colorNameEn,
      "color_name_ar": colorNameAr,
      "hex_code_color": hexCodeColor,
      "colors_id": colorID,
    };
  }
}



// {
//             "color_name_ar": "كحلي",
//             "color_name_en": "navy blue",
//             "hex_code_color": "#2D3357"
//         }