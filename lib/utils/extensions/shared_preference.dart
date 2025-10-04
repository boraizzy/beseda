import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  static const String isFirstTimeOnboarding = 'isFirstTimeOnboarding';
  static const String isFirstTimeWelcomeScreen = 'isFirstTimeWelcomeScreen';
  static const String isUserLoggedIn = 'isUserLoggedIn';
  static const accessTokenKey = 'accessTokenKey';
  static const refreshTokenKey = 'refreshTokenKey';
  static const idToken = 'idToken';
  static const fcmTokenKey = 'fsmTokenKey';
  static const userName = 'userName';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const firstTimeChoosePlan = 'firstTimeChoosePlan';
  static const userId = 'userId';
  static const customerId = 'customerId';

  static Future<bool> getIsFirstTimeOnboarding() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isFirstTimeOnboarding) ?? true;
  }

  static Future<void> setFirstTimeOnboarding(bool isFirstTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(isFirstTimeOnboarding, isFirstTime);
  }

  static Future<bool> getFirstTimeWelcomeScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isFirstTimeWelcomeScreen) ?? true;
  }

  static Future<void> setFirstTimeWelcomeScreen(bool isFirstTimeWelcome) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(isFirstTimeWelcomeScreen, isFirstTimeWelcome);
  }

  static Future<bool> getUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isUserLoggedIn) ?? false;
  }

  static Future<void> setUserLoggedIn(bool isFirstTimeLogin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(isUserLoggedIn, isFirstTimeLogin);
  }

  static Future<String> getAccessKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(accessTokenKey) ?? '';
  }

  static Future<void> setAccessKey(String accessKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(accessTokenKey, accessKey);
  }

  static Future<void> removeAccessKey(String accessKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(
      accessTokenKey,
    );
  }

  static Future<String> getRefreshKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(refreshTokenKey) ?? '';
  }

  static Future<void> setRefreshKey(String refreshKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(refreshTokenKey, refreshKey);
  }

  static Future<void> removeRefreshKey(String refreshKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(
      refreshTokenKey,
    );
  }

  static Future<String> getIdToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(idToken) ?? '';
  }

  static Future<void> setIdToken(String userIdToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(idToken, userIdToken);
  }

  static Future<void> removeIdToken(String refreshKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(idToken);
  }

  static Future<String> getFcmTokenKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(fcmTokenKey) ?? '';
  }

  static Future<void> setFcmTokenKey(String fcm) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(fcmTokenKey, fcm);
  }

  static Future<String> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userName) ?? '';
  }

  static Future<void> setUserName(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(userName, username);
  }


  static Future<String> getFirstName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(firstName) ?? '';
  }

  static Future<void> setFirstName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(firstName, name);
  }

  static Future<String> getLastName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(lastName) ?? '';
  }

  static Future<void> setLastName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(lastName, name);
  }

  static void clearData(){
    AppSharedPreference.setAccessKey("");
    AppSharedPreference.setRefreshKey("");
    AppSharedPreference.setIdToken("");
    AppSharedPreference.setUserName("");
    AppSharedPreference.setUserLoggedIn(false);
    AppSharedPreference.setFirstName("");
    AppSharedPreference.setLastName("");
    AppSharedPreference.setUserId("");
    AppSharedPreference.setCustomerId("");
    AppSharedPreference.setPurchasedPlanId("");
  }





  static Future<String> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userId) ?? '';
  }

  static Future<void> setUserId(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(userId, username);
  }

  static Future<String> getCustomerId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(customerId) ?? '';
  }

  static Future<void> setCustomerId(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(customerId, username);
  }


  static const _purchasedPlanKey = "purchased_plan_id";

  static Future<void> setPurchasedPlanId(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_purchasedPlanKey, planId);
  }

  static Future<String?> getPurchasedPlanId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_purchasedPlanKey);
  }

}
