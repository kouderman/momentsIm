import '../httpbean/respprofile.dart';

class AppData {
  static AppData _instance;

  AppData._internal();

  // 工厂构造函数
  factory AppData() {
    if (_instance == null) {
      _instance = AppData._internal();
    }

    return _instance;
  }

  static String licence = '';
  static String manager = '';
  static Respprofile respprofile;
}
