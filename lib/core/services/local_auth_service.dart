import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {
  const LocalAuthService();

  static const _isLoggedInKey = 'isLoggedIn';
  static const _userRoleKey = 'userRole';
  static const _userNameKey = 'userName';
  static const _userPhoneKey = 'userPhone';

  static const clientRole = 'client';
  static const adminRole = 'admin';
  static const adminUsername = 'admin';
  static const adminPassword = '1234';

  Future<void> loginClient({
    required String name,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userRoleKey, clientRole);
    await prefs.setString(_userNameKey, name);
    await prefs.setString(_userPhoneKey, phone);
  }

  Future<bool> loginAdmin({
    required String username,
    required String password,
  }) async {
    final valid = username.trim() == adminUsername && password == adminPassword;
    if (!valid) return false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userRoleKey, adminRole);
    await prefs.setString(_userNameKey, 'مدير النظام');
    await prefs.remove(_userPhoneKey);
    return true;
  }

  Future<void> registerClient({
    required String name,
    required String phone,
    required String password,
  }) async {
    await loginClient(name: name, phone: phone);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userRoleKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userPhoneKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneKey);
  }
}
