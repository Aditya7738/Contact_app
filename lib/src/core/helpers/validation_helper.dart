import 'package:contact_app/src/core/constants/strings.dart';
import 'package:flutter/services.dart';

class ValidationHelper{
  static String? oldpassword = null;
  static String? checkIsNullOrEmpty(String? inputText){

    if(inputText == null || inputText.trim().isEmpty){
      return Strings.fieldEmptyMsg;
    }
    return null;

  }




  static String? validateEmail(String? inputText){
    String? errorMsg = checkIsNullOrEmpty(inputText);

    if(errorMsg != null){
      return errorMsg;
    }

    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(inputText!);

    if(!emailValid){
      return Strings.emailErrorMsg;
    }
    return null;

  }

  static String? validatePassword(String? inputText){
    String? errorMsg = checkIsNullOrEmpty(inputText);

    if(errorMsg != null){
      return errorMsg;
    }

    final bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(inputText!);

    if(!passValid){
      return Strings.passErrorMsg;
    }else{
      oldpassword = inputText;
      return null;
    }
  }


  static String? validatePhone(String? phoneNumber) {

    String? nullablePhone = checkIsNullOrEmpty(phoneNumber);

    if (nullablePhone != null) {
      return nullablePhone;
    }

    bool isValidPhone = RegExp(r'^\d{10}$').hasMatch(phoneNumber!);

    if (!isValidPhone) {
      return 'Enter a valid phone number';
    }
    return null;
  }



  static String? passwordMatch(String? inputText, String? val) {
    String? errorMsg = checkIsNullOrEmpty(inputText);

    if (errorMsg != null) {
      return errorMsg;
    }

    if(inputText != oldpassword){
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateName(String? name) {
    String? nullableName = checkIsNullOrEmpty(name);
    if (nullableName != null) {
      return nullableName;
    }

    if (name!.length <= 3) {
      return 'Name must contain at least 3 characters.';
    }

    return null;
  }

  static String? validateAddress(String? address) {
    String? nullableName = checkIsNullOrEmpty(address);
    if (nullableName != null) {
      return nullableName;
    }

    if (address!.length <= 3) {
      return Strings.addressErrorMsg;
    }

    return null;
  }

  // static String? validatePassword(String? inputText){
  //   String? errorMsg = checkIsNullOrEmpty(inputText);
  //
  //   if(errorMsg != null){
  //     return errorMsg;
  //   }
  //
  //   final bool isThereUpperCase = RegExp(r'^(?=.*?[A-Z])$').hasMatch(inputText!);
  //   final bool isThereLowerCase = RegExp(r'^(?=.*?[a-z])$').hasMatch(inputText!);
  //   final bool isThereNumber = RegExp(r'^(?=.*?[0-9])$').hasMatch(inputText!);
  //   final bool isThereSymbol = RegExp(r'^(?=.*?[!@#\$&*~])$').hasMatch(inputText!);
  //   final bool isLengthEight = RegExp(r'.{8,}^$').hasMatch(inputText!);
  //
  //   if(!isThereUpperCase){
  //     return Strings.upperCaseErrorMsg;
  //   }else if(!isThereLowerCase){
  //     return Strings.lowerCaseErrorMsg;
  //   }else if(!isThereNumber){
  //     return Strings.numberErrorMsg;
  //   }else if(!isThereSymbol){
  //     return Strings.symbolErrorMsg;
  //   }else if(!isLengthEight){
  //     return Strings.lengthErrorMsg;
  //   }else{
  //     return null;
  //   }
  //
  //
  //
  // }

}