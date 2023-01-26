class UserData {
  late String userId;
  late String email;
  late String socialId;
  late String userName;
  late String phone;
  late String referralCode;
  late int userBonusBalance;
  late int userWinningAmountBalance;
  late String userWalletPoints;
  late String loginType;
  late String language;
  late String profilePic;
  late String pushNotificationStatus;
  late String signupFrom;
  late String lastLoginDate;
  late String profileCompleted;
  late String status;
  late String authKey;
  late String fullName = "";
  late int userDepositBalance;
  late String socketId;
  late int totalWalletAmount;

  UserData(
      {required this.userId,
      required this.email,
      required this.socialId,
      required this.userName,
      required this.phone,
      required this.referralCode,
      required this.userBonusBalance,
      required this.userWinningAmountBalance,
      required this.userWalletPoints,
      required this.loginType,
      required this.language,
      required this.profilePic,
      required this.pushNotificationStatus,
      required this.signupFrom,
      required this.lastLoginDate,
      required this.profileCompleted,
      required this.status,
      required this.authKey,
      required this.fullName,
      required this.userDepositBalance,
      required this.socketId,
      required this.totalWalletAmount});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    socialId = json['social_id'];
    userName = json['user_name'];
    phone = json['phone'];
    referralCode = json['referral_code'];
    userBonusBalance = json['user_bonus_balance'];
    userWinningAmountBalance = json['user_winning_amount_balance'];
    userWalletPoints = json['user_wallet_points'];
    loginType = json['login_type'];
    language = json['language'];
    profilePic = json['profile_pic'];
    pushNotificationStatus = json['push_notification_status'];
    signupFrom = json['signup_from'];
    lastLoginDate = json['last_login_date'];
    profileCompleted = json['profile_completed'];
    status = json['status'];
    authKey = json['auth_key'];
    fullName = json['full_name'];
    userDepositBalance = json['user_deposit_balance'];
    socketId = json['socket_id'];
    totalWalletAmount = json['total_wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['email'] = email;
    data['social_id'] = socialId;
    data['user_name'] = userName;
    data['phone'] = phone;
    data['referral_code'] = referralCode;
    data['user_bonus_balance'] = userBonusBalance;
    data['user_winning_amount_balance'] = userWinningAmountBalance;
    data['user_wallet_points'] = userWalletPoints;
    data['login_type'] = loginType;
    data['language'] = language;
    data['profile_pic'] = profilePic;
    data['push_notification_status'] = pushNotificationStatus;
    data['signup_from'] = signupFrom;
    data['last_login_date'] = lastLoginDate;
    data['profile_completed'] = profileCompleted;
    data['status'] = status;
    data['auth_key'] = authKey;
    data['full_name'] = fullName;
    data['user_deposit_balance'] = userDepositBalance;
    data['socket_id'] = socketId;
    data['total_wallet_amount'] = totalWalletAmount;
    return data;
  }

  @override
  String toString() {
    return 'UserData{userId: $userId, email: $email, socialId: $socialId, userName: $userName, phone: $phone, referralCode: $referralCode, userBonusBalance: $userBonusBalance, userWinningAmountBalance: $userWinningAmountBalance, userWalletPoints: $userWalletPoints, loginType: $loginType, language: $language, profilePic: $profilePic, pushNotificationStatus: $pushNotificationStatus, signupFrom: $signupFrom, lastLoginDate: $lastLoginDate, profileCompleted: $profileCompleted, status: $status, authKey: $authKey, fullName: $fullName, userDepositBalance: $userDepositBalance, socketId: $socketId, totalWalletAmount: $totalWalletAmount}';
  }
}
