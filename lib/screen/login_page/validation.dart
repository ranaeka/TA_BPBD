class Validation {
  String validatePassword(String value) { 
    if (value.length < 6) { 
      return 'Password Minimal 6 Karakter';
    }
    return null; 
  }

  String validateEmail(String value) {
    if (!value.contains('@')) { 
      return 'Email Harus Diisi'; 
    }
    return null;
  }

}