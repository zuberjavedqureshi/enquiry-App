class NameValidator {
  static validator(String value) {
    if (value.isEmpty) {
      return "Name can't be empty!";
    }
    if (value.length < 2) {
      return "Name must be at least 2 character long!";
    }
    if (value.length > 50) {
      return "Name must be less than 50 character long1";
    }
    return null;
  }
}

class AddressValidator {
  static validator(String value) {
    if (value.isEmpty) {
      return "Adaress can't be empty!";
    }
    if (value.length < 2) {
      return "Address must be at least 2 character long!";
    }
    // if (value.length > 150) {
    //   return "Address must be less than 150 character long";
    // }
    return null;
  }
}

class AdminValidator {
  static validator(String value) {
    if (value.isEmpty) {
      return "Please write the Admin Name!";
    }
  }
}

class AdmissionValidator {
  static validator(String value) {
    if (value.isEmpty) {
      return "Please write the Purpose OR Admission for!";
    }
  }
}

class MobileValidator {
  static validator(String value) {
    if (value.isEmpty) {
      return "Please Enter the mobile number!";
    }
    if (value.length != 10) {
      return "Please Enter the valid mobile number!";
    }
  }
}

class ReasonValidator {
  static validator(String value) {
    if (value.isEmpty) {
      return "Please write the Reason";
    }
  }
}
