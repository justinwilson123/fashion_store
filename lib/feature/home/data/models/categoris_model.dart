import '../../domain/entiti/discove_entities.dart';

class CategoreisModel extends CategoryEntiti {
  const CategoreisModel({
    required super.categoryId,
    required super.categoryNameAr,
    required super.categoryNameEn,
  });

  factory CategoreisModel.fromJson(Map<String, dynamic> json) {
    return CategoreisModel(
      categoryId: json['category_id'],
      categoryNameAr: json['category_name_ar'],
      categoryNameEn: json['category_name_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category_id": categoryId,
      "category_name_ar": categoryNameAr,
      "category_name_en": categoryNameEn,
    };
  }
}
