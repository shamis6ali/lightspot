import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppPreferences {
  // Keys
  static const String FINISHED_ONBOARDING = 'finished_onboarding';
  static const String ACCESS_TOKEN = 'access_token';
  static const String EXPIRES_AT = 'expires_at';
  static const String CACHED_USER = 'cached_user';
  static const String LANGUAGE = 'language';
  static const String HAS_USER = 'has_user';
  static const String IS_LOGGED_IN = 'is_logged_in';

  static const String prefix = 'AppPreference.';

  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String methods
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString('$prefix$key', value);
  }

  static String? getString(String key) {
    return _prefs.getString('$prefix$key');
  }

  static String getStringOrDefault(String key, String defaultValue) {
    return _prefs.getString('$prefix$key') ?? defaultValue;
  }

  // Boolean methods
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool('$prefix$key', value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool('$prefix$key');
  }

  static bool getBoolOrDefault(String key, bool defaultValue) {
    return _prefs.getBool('$prefix$key') ?? defaultValue;
  }

  // Integer methods
  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt('$prefix$key', value);
  }

  static int? getInt(String key) {
    return _prefs.getInt('$prefix$key');
  }

  static int getIntOrDefault(String key, int defaultValue) {
    return _prefs.getInt('$prefix$key') ?? defaultValue;
  }

  // Double methods
  static Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble('$prefix$key', value);
  }

  static double? getDouble(String key) {
    return _prefs.getDouble('$prefix$key');
  }

  static double getDoubleOrDefault(String key, double defaultValue) {
    return _prefs.getDouble('$prefix$key') ?? defaultValue;
  }

  // DateTime methods
  static Future<bool> setDateTime(String key, DateTime value) async {
    return await _prefs.setString('$prefix$key', value.toIso8601String());
  }

  static DateTime? getDateTime(String key) {
    final value = _prefs.getString('$prefix$key');
    if (value != null) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // List<String> methods
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList('$prefix$key', value);
  }

  static List<String>? getStringList(String key) {
    return _prefs.getStringList('$prefix$key');
  }

  static List<String> getStringListOrDefault(String key, List<String> defaultValue) {
    return _prefs.getStringList('$prefix$key') ?? defaultValue;
  }

  // Generic remove method
  static Future<bool> remove(String key) async {
    return await _prefs.remove('$prefix$key');
  }

  // Clear all preferences
  static Future<bool> clear() async {
    return await _prefs.clear();
  }

  // Clear specific auth data
  static Future<void> clearAuthData() async {
    await remove(CACHED_USER);
    await remove(EXPIRES_AT);
    await remove(ACCESS_TOKEN);
    await remove(HAS_USER);
    await remove(IS_LOGGED_IN);
  }

  // Auth-specific convenience methods
  static Future<bool> setFinishedOnboarding(bool value) async {
    return await setBool(FINISHED_ONBOARDING, value);
  }

  static bool getFinishedOnboarding() {
    return getBoolOrDefault(FINISHED_ONBOARDING, false);
  }

  static Future<bool> setAccessToken(String token) async {
    return await setString(ACCESS_TOKEN, token);
  }

  static String? getAccessToken() {
    return getString(ACCESS_TOKEN);
  }

  static Future<bool> setExpiresAt(DateTime expiresAt) async {
    return await setDateTime(EXPIRES_AT, expiresAt);
  }

  static DateTime? getExpiresAt() {
    return getDateTime(EXPIRES_AT);
  }

  static Future<bool> setCachedUser(String userJson) async {
    return await setString(CACHED_USER, userJson);
  }

  static String? getCachedUser() {
    return getString(CACHED_USER);
  }

  static Future<bool> setLanguage(String language) async {
    return await setString(LANGUAGE, language);
  }

  static String getLanguage() {
    return getStringOrDefault(LANGUAGE, 'en');
  }

  static Future<bool> setHasUser(bool hasUser) async {
    return await setBool(HAS_USER, hasUser);
  }

  static bool getHasUser() {
    return getBoolOrDefault(HAS_USER, false);
  }

  static Future<bool> setIsLoggedIn(bool isLoggedIn) async {
    return await setBool(IS_LOGGED_IN, isLoggedIn);
  }

  static bool getIsLoggedIn() {
    return getBoolOrDefault(IS_LOGGED_IN, false);
  }

  // Check if token is expiring soon (within 5 hours)
  static bool isTokenExpiringSoon() {
    final expiresAt = getExpiresAt();
    if (expiresAt == null) return false;
    
    final now = DateTime.now();
    final fiveHoursFromNow = now.add(const Duration(hours: 5));
    
    return expiresAt.isBefore(fiveHoursFromNow);
  }

  // Check if user is logged in and has valid token
  static bool isAuthenticated() {
    final isLoggedIn = getIsLoggedIn();
    final hasToken = getAccessToken()?.isNotEmpty == true;
    final tokenNotExpired = !isTokenExpiringSoon();
    
    return isLoggedIn && hasToken && tokenNotExpired;
  }
}