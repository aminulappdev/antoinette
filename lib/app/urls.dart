class Urls {
  static const String _baseUrl = 'http://192.168.10.144:5001/api/v1';

  static const String signUp = '$_baseUrl/users/register';
  static const String verifOtp = '$_baseUrl/otp/verify-otp';
  static const String signIn = '$_baseUrl/auth/login';
  static const String forgotPassword = '$_baseUrl/auth/forget-password';
  static const String resendOTP = '$_baseUrl/otp/resend-otp';
  static const String resetPassword = '$_baseUrl/auth/reset-password';
  static const String googleAuth = '$_baseUrl/auth/google';
  static const String facebookAuth = '$_baseUrl/auth/facebook';
  static const String allProductUrl = '$_baseUrl/products';
  static const String allsessionUrl = '$_baseUrl/sessions';
  static String productUrlsById(String id,) {
    return '$_baseUrl/products/$id';
  }

}
