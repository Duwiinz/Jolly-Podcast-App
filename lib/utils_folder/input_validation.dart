class Validator {
  // check field is not empty
  static String? fieldNotEmpty(fieldValue) {
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field";
    }
    return null;
  }

  // for text and number
  static String? validateTextField(fieldValue) {
    String pattern = r'^[a-z A-Z 0-9]';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field";
    }
    return null;
  }

  // for text only
  static String? validateTextForAlphabet(fieldValue) {
    String pattern = r'^[a-z A-Z 0-9]';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be alphabet";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field must be alphabet";
    }

    // check if it contains or special characters
    if (fieldValue.toString().contains(RegExp(r"[0-9]")) ||
        (fieldValue.toString().contains(RegExp(r'[/!@#$%^&*(),.?":{}|<>]')))) {
      return "* required field must be alphabet";
    }

    return null;
  }

  static String? validateDigitsField(fieldValue) {
    String pattern = r'^[0-9]';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be number or enter Zero";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field must be number or enter Zero";
    }
    return null;
  }

  static String? validateDropDown(fieldValue) {
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field";
    }

    return null;
  }

  // static String? validateEmail(fieldValue) {
  //   var pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
  //   RegExp regex = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return "* required field must be a valid email";
  //   } else if (!regex.hasMatch(fieldValue)) {
  //     return "* required field must be a valid email";
  //   }
  //   return null;
  // }

  //  to support email of such patterns too...E.g cpak@qompass-solutions.com
  static String? validateEmail(fieldValue) {
    var pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be a valid email";
    } else if (!regex.hasMatch(fieldValue)) {
      return "* required field must be a valid email";
    }
    return null;
  }

  static String? validateMobile(fieldValue) {
    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be 11 digits";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field must be 11 digits";
    }
    return null;
  }

  static String? validateSecurityPin(fieldValue) {
    String pattern = r'(^(?:[+0]9)?[0-9]{4}$)';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be 4 digits";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field must be 4 digits";
    }
    return null;
  }

  static String? validateAccountNumber(fieldValue) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be 10 digits";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field must be 10 digits";
    }
    return null;
  }

  static String? validateBVN(fieldValue) {
    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
    RegExp regExp = RegExp(pattern);
    if (fieldValue == null || fieldValue.toString().isEmpty) {
      return "* required field must be 11 digits";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "* required field must be 11 digits";
    }
    return null;
  }

  // static bool isPasswordValid(String password) {
  //   if (password.length < 7) return false;
  //   if (!password.contains(RegExp(r"[a-z]"))) return false;
  //   if (!password.contains(RegExp(r"[A-Z]"))) return false;
  //   if (!password.contains(RegExp(r"[0-9]"))) return false;
  //   if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
  //   return true;
  // }

  static String? isPasswordValid(String? password) {
  if (password == null || password.isEmpty) {
    return "* password is required";
  }

  if (password.length < 15) {
    return "* password must be at least 15 characters";
  }

  // At least one letter
  if (!RegExp(r"[a-zA-Z]").hasMatch(password)) {
    return "* must contain at least one letter";
  }

  // At least one number
  if (!RegExp(r"[0-9]").hasMatch(password)) {
    return "* must contain at least one number";
  }

  // At least one special character (includes @)
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return "* must contain at least one special character (e.g. @)";
  }

  return null; // ✅ valid password
}

}
