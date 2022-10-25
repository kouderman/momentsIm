import 'package:logger/logger.dart';

class LoggerUtil {
  LoggerUtil.v(dynamic v) {
    if (Config.isDebug) {
      Logger().v(v);
    }
  }

  /// 调试
  LoggerUtil.d(dynamic d, {dynamic tag}) {
    if (Config.isDebug) {
      Logger().d(d, tag);
    }
  }

  /// 信息
  LoggerUtil.i(dynamic i, {dynamic tag}) {
    if (Config.isDebug) {
      Logger().i(i, tag);
    }
  }

  /// 错误
  LoggerUtil.e(dynamic e, {dynamic tag}) {
    if (Config.isDebug) {
      Logger().e(e, tag);
    }
  }

  /// 警告
  LoggerUtil.w(dynamic w) {
    if (Config.isDebug) {
      Logger().w(w);
    }
  }

  /// WTF
  LoggerUtil.wtf(dynamic wtf) {
    if (Config.isDebug) {
      Logger().wtf(wtf);
    }
  }
}

class Config {
  static bool isDebug =true;
}
