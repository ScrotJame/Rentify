class Validation{
  static String? validatePass(String pass) {
    if(pass.isEmpty){
      return "Password invalid";
    }
    if(pass.length<8){
      return "Khong du 8 ky tu";
    }
    return null;
  }
  static String? validateEmail(String email) {
    if(email.isEmpty){
      return "Email invalid";
    }
    var isValid=
        RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]").hasMatch(email);
    if(!isValid)
      {
        return "Email invalid";
      }

    return null;
  }
}