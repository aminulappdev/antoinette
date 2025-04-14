class Urls {
  static const String _baseUrl = 'http://192.168.10.144:5001/api/v1';
  // static const String _baseUrl = 'https://488b-115-127-156-9.ngrok-free.app/api/v1';
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
  static const String allarticlesUrl = '$_baseUrl/articles';
  static const String allpodcastUrl = '$_baseUrl/podcasts';
  static const String addContactUrl = '$_baseUrl/trusted-contracts';
  static const String allContacturl = '$_baseUrl/trusted-contracts';
  static const String profileUrl = '$_baseUrl/users/my-profile';
  static const String updateProfileUrl = '$_baseUrl/users/update-my-profile';
  static const String addCheckIn = '$_baseUrl/check-in';
  static const String allCheckInUrl = '$_baseUrl/check-in'; 
  static const String contentUrl = '$_baseUrl/contents'; 
  static const String bookmarkUrl = '$_baseUrl/content-bookmarks'; 
  static const String bookingSessionUrl = '$_baseUrl/bookings'; 
  static const String bookmarkArticleUrl = '$_baseUrl/content-bookmarks/my-bookmarks'; 
  static const String addDiariesUrl = '$_baseUrl/dear-dairies'; 
  static const String setJournalKeyUrl = '$_baseUrl/journal-key/add-key'; 
  static const String changeJournalKeyUrl = '$_baseUrl/journal-key/change-key'; 
  static const String accessJournalKeyUrl = '$_baseUrl/journal-key/access-journal'; 
  static const String allPackageUrl = '$_baseUrl/packages'; 
  static const String subscriptionUrl = '$_baseUrl/subscriptions'; 
  static const String dashboardUrl = '$_baseUrl/dear-dairies/dashboard-data'; 
  static const String allDiarydUrl = '$_baseUrl/dear-dairies'; 
  static const String orderProductUrl = '$_baseUrl/orders'; 

   


  static String productUrlsById(
    String id,
  ) {
    return '$_baseUrl/products/$id';
  }



  static String sessionUrlsById(
    String id,
  ) {
    return '$_baseUrl/sessions/$id';
  }

  static String articleUrlsById(
    String id,
  ) {
    return '$_baseUrl/articles/$id';
  }

  static String bookmarkContentUrlsById(
    String id,
  ) {
    return '$_baseUrl/content-bookmarks/$id';
  }

    static String podcastUrlsById(
    String id,
  ) {
    return '$_baseUrl/podcasts/$id';
  }

  static String sessionSlotById(
    String id,
  ) {
    return '$_baseUrl/session-slots/session/$id';
  }

  static String deleteContactById(
    String id,
  ) {
    return '$_baseUrl/trusted-contracts/$id';
  }
}
