import 'package:fashion/feature/product_details/domain/entity/details_entities.dart';

class SizesModel extends SizedEntity {
  const SizesModel({
    required super.sizeName,
    required super.sizeID,
  });

  factory SizesModel.fromJson(Map<String, dynamic> json) {
    return SizesModel(
      sizeName: json['sized_name'],
      sizeID: json['size_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sized_name": sizeName,
      "size_id": sizeID,
    };
  }
}
