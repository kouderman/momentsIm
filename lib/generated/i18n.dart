import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "WeChat";
  String get australia => "Australia";
  String get canada => "Canada";
  String get chinaMainland => "China Mainland";
  String get contacts => "Contacts";
  String get discover => "Discover";
  String get emergencyFreeze => "freeze";
  String get exampleName => "For example: Chen Chen";
  String get hongKong => "Hong Kong";
  String get label => "test";
  String get language => "Language";
  String get languageTitle => "Change Language";
  String get login => "Login";
  String get macao => "Macao";
  String get me => "Me";
  String get mobileNumberLogin => " number login";
  String get multiLanguage => "Multi-Language";
  String get nextStep => "login";
  String get nickName => "nickname";
  String get notOpen => "Not yet open";
  String get numberRegister => "Mobile number registration";
  String get passWord => "passWord";
  String get passWordTwo => "passWord sure";
  String get passWordTwoHint => "Please fill in your password again";
  String get eamil => "email";
  String get gender => "gender";
  String get male => "male";
  String get female => "female";
  String get eamilTip => "Please fill in your email";
  String get phoneCity => "Country";
  String get phoneNumber => "Phone/email";
  String get inputpwd => "password";
  String get phoneNumberHint => "Please fill in your phone number or email";
  String get phoneNumberHintpwd => "Please fill in your password";
  String get protocolName => "[ WeChat protocol ]";
  String get protocolTitle => "WeChat Software License and Service Agreement";
  String get protocolUrl => "https://weixin.qq.com/cgi-bin/readtemplate?lang=en&t=weixin_agreement&s=default&cc=CN";
  String get pwTip => "Fill in the password";
  String get readAgree => "ReadAgree ";
  String get register => "Register";
  String get retrievePW => "Retrieve";
  String get xing => "your name";
  String get xinghint => "please input your name";
  String get xingname => "your full name";
  String get xingnamehint => "please input your full name";
  String get selectCountry => "Select country or region";
  String get singapore => "Singapore";
  String get taiwan => "Taiwan";
  String get uS => "United States";
  String get userLoginTip => "WeChat number / QQ number / email";
  String get weChat => "WeChat";
  String get weChatSecurityCenter => "Security";
}

class $en extends S {
  const $en();
}

class $zh_CN extends S {
  const $zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get passWord => "??????";
  @override
  String get eamil => "??????";
  @override
  String get readAgree => "?????????????????? ";
  @override
  String get eamilTip => "??????????????? ";
  @override
  String get inputpwd => "??????????????? ";
  @override
  String get weChatSecurityCenter => "??????????????????";
  @override
  String get numberRegister => "???????????????";
  @override
  String get emergencyFreeze => "????????????";
  @override
  String get multiLanguage => "?????????";
  @override
  String get language => "??????";
  @override
  String get login => "??????";
  @override
  String get selectCountry => "?????????????????????";
  @override
  String get macao => "??????";
  @override
  String get protocolName => "?????????????????????????????????";
  @override
  String get userLoginTip => "????????????/QQ???/????????????";
  @override
  String get me => "???";
  @override
  String get phoneNumberHint => "????????????????????????";
  @override
  String get phoneNumberHintpwd => "?????????????????????";
  @override
  String get phoneCity => "??????/??????";
  @override
  String get chinaMainland => "????????????";
  @override
  String get discover => "??????";
  @override
  String get notOpen => "????????????";
  @override
  String get mobileNumberLogin => "??????";
  @override
  String get appName => "??????";
  @override
  String get nickName => "?????????";
  @override
  String get australia => "????????????";
  @override
  String get label => "??????";
  @override
  String get xingname => "????????????";
  @override
  String get xingnamehint => "?????????????????????";
  @override
  String get languageTitle => "????????????";
  @override
  String get hongKong => "??????";
  @override
  String get protocolTitle => "???????????????????????????";
  @override
  String get singapore => "?????????";
  @override
  String get taiwan => "??????";
  @override
  String get phoneNumber => "??????/??????";
  @override
  String get canada => "?????????";
  @override
  String get retrievePW => "????????????";
  @override
  String get pwTip => "????????????";
  @override
  String get nextStep => "??????";
  @override
  String get weChat => "??????";
  @override
  String get passWordTwo => "????????????";
  @override
  String get gender => "????????????";
  @override
  String get xing => "????????????";
  @override
  String get xinghint => "??????????????????";
  @override
  String get passWordTwoHint => "?????????????????????";
  @override
  String get male => "???";
  @override
  String get female => "???";
  @override
  String get exampleName => "??????: ??????";
  @override
  String get uS => "??????";
  @override
  String get protocolUrl => "https://weixin.qq.com/agreement?lang=zh_CN";
  @override
  String get contacts => "??????";
  @override
  String get register => "??????";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("zh", "CN"),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "zh_CN":
          S.current = const $zh_CN();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
