class Validation {
  bool isEmail(String em) {
    RegExp regExp;
    if (em.length <= 32) {
      String p =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      regExp = new RegExp(p);
      return regExp.hasMatch(em);
    }
    return false;
  }

  bool chekErr(String err) {
    if (err.isEmpty)
      return false;
    else
      return true;
  }
}
