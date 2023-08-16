class AuthValidators {

  static const String emailErrMsg = 
    "Invalid Email Adress, Please provide a valid Email.";

  static const String passwordErrMsg = 
    "Password must have atleast 6 characters";

  static const String confirmPasswordErrMsg = 
    "Password does not match, Please verify and retry";

  static String? firstPass;

  String? emailValidator(String? val) {

    final String email = val as String;
    
    if (email.length <= 3) return emailErrMsg;

    // Check if it has @
    final hasAtSymbol = email.contains('@');

    // find position of @
    final indexOfAt = email.indexOf('@');

    // Check numbers of @
    final numbersOfAt = "@".allMatches(email).length;

    // Valid if has @
    if (!hasAtSymbol) return emailErrMsg;

    // and  if number of @ is only 1
    if (numbersOfAt != 1) return emailErrMsg;

    //and if  '@' is not first or last character
    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    // Else its valid
    return null;
  }
  
  String? passwordVlidator(String? val) {

    final String password = val as String;
    if (password.isEmpty || password.length <= 5) return passwordErrMsg;
    return null;

  }

  // Confirm password
  String? confirmPasswordValidator(String? val) {
    final String? firstPassword = firstPass;
    final String secondPassword = val as String;
    
    if(firstPassword == null || firstPassword.isEmpty)
    {
      return 'First Enter Password then confirm it , You Fool!!';
    }
    else if(firstPassword.isEmpty ||
        secondPassword.isEmpty ||
        firstPassword.length != secondPassword.length) {
      return confirmPasswordErrMsg;
    }
    
    if (firstPassword != secondPassword) return confirmPasswordErrMsg;
    return null;
  }

  String? check(String? val) {
    return null;
  }
}