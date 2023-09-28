import 'package:flutter/foundation.dart';

import '../../app/env.dart';
import '../../app/locator.dart';

class ApiEndpoints {
  static const String _versionOne = '/api/v1';
  static const String _versionTwo = '/api/v2';

  static const _isDebug = kDebugMode;

  static final String _baseUrlV1 = (() {
    if (_isDebug) {
      return getIt<ENV>().apiBaseUrl + _versionOne;
    } else {
      return getIt<ENV>().prodApiBaseUrl + _versionOne;
    }
  })();

  static final String _baseUrlV2 = (() {
    if (_isDebug) {
      return getIt<ENV>().apiBaseUrl + _versionTwo;
    } else {
      return getIt<ENV>().prodApiBaseUrl + _versionTwo;
    }
  })();

  String get baseUrl => _baseUrlV1;

  /// Auth
  static final String login = '$_baseUrlV2/auth/login';
  static final String logout = '$_baseUrlV1/auth/logout';
  static final String signUp = '$_baseUrlV1/auth/signup';
  static final String getCountries = '$_baseUrlV1/countries';
  static final String sendCodeToEmail = '$_baseUrlV1/auth/verify-email';
  static final String setPin = '$_baseUrlV1/profile/transaction-pin';
  static final String setKYC = '$_baseUrlV1/profile/kyc';
  static String updateKYC(String id) => '$_baseUrlV1/profile/kyc/$id';
  static final String updateBVN = '$_baseUrlV1/profile/update-bvn';
  static final String recoverPassword = '$_baseUrlV1/auth/recover-password';
  static String resetPassword(String email, String token) =>
      '$_baseUrlV1/auth/reset-password?email=$email&token=$token';

  /// Profile
  static String getKyc(int id) => '$_baseUrlV1/profile/kyc/$id';
  static final String getProfile = '$_baseUrlV2/auth/user';
  static final String updatePassword = '$_baseUrlV1/profile/change-password';
  static final String changePin = '$_baseUrlV1/profile/transaction-pin';
  static final String resetPin = '$_baseUrlV1/profile/transaction-pin/reset';
  static final String recoverPin =
      '$_baseUrlV1/profile/transaction-pin/recover';
  static final String addNextOfKin = '$_baseUrlV1/profile/next-of-kin';
  static final String getReferral = '$_baseUrlV1/profile/referrals';
  static final String addAvatar = '$_baseUrlV1/profile/avatar';
  static final String deleteAccount = '$_baseUrlV1/profile';
  static final String saveStatement = '$_baseUrlV1/statement-report';
  static final String getRecoinWallet = '$_baseUrlV1/recoin';
  static final String enableSMS = '$_baseUrlV1/profile/enable-sms';

  // Wallet
  static String getVirtualAccount(String ref) =>
      '$_baseUrlV1/virtual-account/$ref?provider=safe-haven';
  static String getWallet(String ref) => '$_baseUrlV2/wallet/$ref';

  // Send Money
  static String sendToReconUser(String reference) =>
      '$_baseUrlV1/send-money/$reference/recon-user';
  static String resolveUsername(String username) =>
      '$_baseUrlV1/misc/resolve-username/$username';
  static String sendToBank(String reference) =>
      '$_baseUrlV1/send-money/$reference/bank-account';
  static String sendViaQrCode(String reference) =>
      '$_baseUrlV1/send-money/$reference/recon-wallet';
  static final String getBeneficiaries = '$_baseUrlV2/send-money/beneficiaries';
  static String getSingleBeneficiary() =>
      '$_baseUrlV2/send-money/beneficiaries';

  // Receive Money
  static String getWalletByRef(String ref) => '$_baseUrlV2/wallet/$ref';
  static final String getQrCode = '$_baseUrlV1/qr-code?status=active';
  static final String createTemporaryQrCode = '$_baseUrlV1/qr-code/temporary';
  static String createVirtualAccount(
    String ref, {
    String provider = "safe-haven",
  }) {
    return '$_baseUrlV1/virtual-account/$ref?provider=$provider';
  }

  // Transactions history
  static String get getTransactions => '$_baseUrlV1/transaction';

  static String getTransactionsRange(DateTime from, DateTime to) =>
      '$_baseUrlV1/transaction?from=${from.toIso8601String()}&to=${to.toIso8601String()}';
  static String getSingleTransaction(String id) =>
      '$_baseUrlV1/transaction/$id';

  // qr code
  static String resolveQrCode(String ref) => '$_baseUrlV1/qr-code/$ref';

  // Bills
  static final String getBillService =
      '$_baseUrlV1/bill/services?provider=safe-haven';
  static String getBillServiceCategories(String id) =>
      '$_baseUrlV1/bill/categories?serviceId=$id&provider=safe-haven';
  static String getBillCategoriesProduct(String id) =>
      '$_baseUrlV1/bill/categories/$id';
  static String purchaseAirtime(String ref, String id) =>
      '$_baseUrlV1/bill/$ref/purchase/airtime?categoryId=$id';
  static String purchaseData(String ref, String id) =>
      '$_baseUrlV1/bill/$ref/purchase/data?categoryId=$id';
  static String verifyPowerCableTvData(String id) =>
      '$_baseUrlV1/bill/verify-power-cable-data?categoryId=$id';
  static String purchaseCable(String ref, String id) =>
      '$_baseUrlV1/bill/$ref/purchase/cable?categoryId=$id';
  static String purchaseUtilityBill(String ref, String id) =>
      '$_baseUrlV1/bill/$ref/purchase/utility?categoryId=$id';

  /// Misc
  static final String getNigeriaBanks = '$_baseUrlV1/misc/banks';
  static final String resolveBank = '$_baseUrlV1/misc/resolve-bank-account';
}
