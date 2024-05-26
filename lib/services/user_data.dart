import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveUserGender(String gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Gender', gender);
  }

  static Future<void> saveUID(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UID', uid);
  }

  static Future<void> saveUserAge(int age) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Age', age);
  }

  static Future<void> saveUserWeight(int weight) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Weight', weight);
  }

  static Future<void> saveUserTall(int tall) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Tall', tall);
  }

  static Future<void> saveUserGoal(String goal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Goal', goal);
  }

  static Future<String?> getUserGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Gender');
  }

  static Future<int?> getUserAge() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('Age');
  }

  static Future<int?> getUserWeight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('Weight');
  }

  static Future<int?> getUserTall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('Tall');
  }

  static Future<String?> getUserGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Goal');
  }

  static Future<String?> getUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('UID');
  }

  static Future<void> removeUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('UID');
  }
}