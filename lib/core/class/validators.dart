import 'package:fashion/core/class/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../error/failure.dart';

class Validators {
  final BuildContext context;
  Validators(this.context);

  String? validatRequird(String? valu) {
    return RequiredValidator(errorText: "13".tr(context)).call(valu);
  }

  String? validatRequirdFullName(String? valu) {
    return MultiValidator([
      RequiredValidator(
        errorText: "13".tr(context),
      ),
      MinLengthValidator(7, errorText: "يجب ان يكون اكبر من 7 احرف"),
      MaxLengthValidator(30, errorText: "يجب ان يكون اقل من 30 حرف "),
    ]).call(valu);
  }

  static String get _emailPattern {
    // final domainsPattern = _allowedDomains
    //     .map((domain) => domain.replaceAll('.', r'\.'))
    //     .join('|');
    return r'(@gmail.com|@yahoo.com|@outlook.com|@hotmail.com)';
  }

  String? emailValid(String? val) {
    return MultiValidator([
      RequiredValidator(errorText: "14".tr(context)),
      EmailValidator(errorText: "15".tr(context)),
      PatternValidator(
        _emailPattern,
        errorText: "16".tr(context),
        caseSensitive: false,
      ),
    ]).call(val);
  }

  String? phoneValidate(String? value) {
    return MultiValidator([
      RequiredValidator(errorText: "17".tr(context)),
      PatternValidator(
        r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
        errorText: "18".tr(context),
      ),
      MinLengthValidator(10, errorText: "19".tr(context)),
      MaxLengthValidator(15, errorText: "20".tr(context)),
    ]).call(value);
  }

  String? passValidate(String? value) {
    return MultiValidator([
      RequiredValidator(errorText: 'كلمة المرور مطلوبة'),
      MinLengthValidator(8, errorText: 'يجب أن تكون 8 أحرف على الأقل'),
      PatternValidator(
        r'(?=.*?[A-Z])',
        errorText: 'يجب أن تحتوي على حرف كبير واحد على الأقل',
      ),
      PatternValidator(
        r'(?=.*?[a-z])',
        errorText: 'يجب أن تحتوي على حرف صغير واحد على الأقل',
      ),
      PatternValidator(
        r'(?=.*?[0-9])',
        errorText: 'يجب أن تحتوي على رقم واحد على الأقل',
      ),
      PatternValidator(
        r'(?=.*?[!@#\$&*~])',
        errorText: 'يجب أن تحتوي على حرف خاص واحد على الأقل',
      ),
    ]).call(value);
  }

  MatchValidator confirmPasswordValidator(String password) {
    return MatchValidator(
      errorText: 'كلمات المرور غير متطابقة',
    );
  }

  static Future<String?> checkEmailUnique(Failure failure) async {
    return failure == EmailUseingFailure()
        ? 'البريد الإلكتروني مسجل مسبقاً'
        : null;
  }

  static Future<String?> checkPhoneUnique(Failure failure) async {
    return failure == PhoneNumberUseingFailure()
        ? 'phone nummber is using'
        : null;
  }
}




// class Validatorss {
//   // التحقق من الحقول الفارغة
//   static final requiredValidator = RequiredValidator(errorText: 'هذا الحقل مطلوب');

//   // تحقق البريد الإلكتروني
//   static final emailValidator = MultiValidator([
//     RequiredValidator(errorText: 'البريد الإلكتروني مطلوب'),
//     EmailValidator(errorText: 'أدخل بريدًا إلكترونيًا صحيحًا'),
//   ]);

//   // تحقق كلمة المرور


//   // تحقق رقم الهاتف (للمثال، يمكن تعديله حسب الدولة)
//   static final phoneValidator = MultiValidator([
//     RequiredValidator(errorText: 'رقم الهاتف مطلوب'),
//     PatternValidator(
//       r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
//       errorText: 'أدخل رقم هاتف صحيح',
//     ),
//     MinLengthValidator(10, errorText: 'يجب أن يكون 10 أرقام على الأقل'),
//     MaxLengthValidator(15, errorText: 'يجب ألا يتجاوز 15 رقماً'),
//   ]);

//   // تحقق مطابقة كلمة المرور
//   static MatchValidator confirmPasswordValidator(String password) {
//     return MatchValidator(
//       errorText: 'كلمات المرور غير متطابقة',
//     );
//   }

//   // دالة مساعدة للتحقق من القوة الكاملة لكلمة المرور
//   static String? checkPasswordStrength(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'كلمة المرور مطلوبة';
//     }

//     if (value.length < 8) {
//       return 'يجب أن تكون 8 أحرف على الأقل';
//     }

//     if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
//       return 'يجب أن تحتوي على حرف كبير واحد على الأقل';
//     }

//     if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
//       return 'يجب أن تحتوي على حرف صغير واحد على الأقل';
//     }

//     if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
//       return 'يجب أن تحتوي على رقم واحد على الأقل';
//     }

//     if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value)) {
//       return 'يجب أن تحتوي على حرف خاص واحد على الأقل';
//     }

//     return null;
//   }
// }