class Urls {
  static const String _baseUrl = 'http://192.168.10.144:5001/api/v1';

  static const String signUp = '$_baseUrl/users/register';
  static const String verifOtp = '$_baseUrl/otp/verify-otp';
  static const String signIn = '$_baseUrl/auth/login';
  static const String forgotPassword = '$_baseUrl/auth/forget-password';


}
