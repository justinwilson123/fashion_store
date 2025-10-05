import 'package:equatable/equatable.dart';

class SizedEntity extends Equatable {
  final String sizeName;
  final int sizeID;
  const SizedEntity({required this.sizeName, required this.sizeID});

  @override
  List<Object?> get props => [sizeName, sizeID];
}

class ColorsEntity extends Equatable {
  final String colorNameEn;
  final String colorNameAr;
  final String hexCodeColor;
  final int colorID;

  const ColorsEntity({
    required this.colorNameEn,
    required this.colorNameAr,
    required this.hexCodeColor,
    required this.colorID,
  });

  @override
  List<Object?> get props => [colorNameAr, colorNameEn, hexCodeColor, colorID];
}
