class PhoneUtils {
  static String normalize(String phone) {
    final cleaned = phone.trim();

    if (cleaned.startsWith('0')) {
      return '234${cleaned.substring(1)}';
    }

    if (cleaned.startsWith('+')) {
      return cleaned.replaceFirst('+', '');
    }

    return cleaned;
  }
}
