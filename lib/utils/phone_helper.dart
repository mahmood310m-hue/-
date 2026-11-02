class PhoneHelper {
  static String? validateIraqiMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    String phone = value.trim();
    if (phone.startsWith('+964')) {
      phone = phone.substring(4);
    } else if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    RegExp regex = RegExp(r'^7[0-9]{9}$');
    if (!regex.hasMatch(phone)) {
      return 'رقم غير صالح لشبكات زين، آسياسيل، أو كورك';
    }
    return null;
  }

  static String formatToE164(String phone) {
    String clean = phone.trim();
    if (clean.startsWith('+964')) return clean;
    if (clean.startsWith('0')) return '+964${clean.substring(1)}';
    return '+964$clean';
  }
}
