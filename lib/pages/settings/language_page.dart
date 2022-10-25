import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/provider/global_model.dart';
import 'package:wechat_flutter/tools/shared_util.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../tools/sp_util.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final List<LanguageData> languageDatas = [
    LanguageData("中文", "zh", "CN", "微信-flutter"),
    LanguageData("English", "en", "US", "Wechat-flutter"),
  ];

  var _groupValue = "中文";

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    _groupValue = model.currentLanguage;

    var body = new ListView(
      children: new List.generate(languageDatas.length, (index) {
        final String languageCode = languageDatas[index].languageCode;
        final String countryCode = languageDatas[index].countryCode;
        final String language = languageDatas[index].language;
        final String appName = languageDatas[index].appName;
        return new RadioListTile(
          value: language,
          groupValue: _groupValue,
          onChanged: (value) {
            print(value);
            _groupValue =language;
            setState(() {

            });

            if(model.goToLogin){
              model.currentLanguageCode = [languageCode, countryCode];
              model.currentLanguage = language;
              model.currentLocale = Locale(languageCode, countryCode);
              model.appName = appName;
              model.refresh();
              SharedUtil.instance.saveStringList(
                  Keys.currentLanguageCode, [languageCode, countryCode]);
              SharedUtil.instance.saveString(Keys.currentLanguage, language);
              SharedUtil.instance.saveString(Keys.appName, appName);
            }else {
              String token = SpUtil.getString("authToken");
              EasyLoading.show(status: '加载中...');
              DioUtil()
                  .post('$baseUrl/language', data: {
                "license": AppData.licence,
                "session_id": token,
                "lang_name": value=="中文"?"china":"english",
              }, errorCallback: (statusCode) {
                EasyLoading.dismiss();
                print('Http error code : $statusCode');
                EasyLoading.showToast(statusCode);
              }).then((data) {
                EasyLoading.dismiss();
                print('Http response: $data');
                if (data != null) {
                  if (data["code"] == 200 || data["code"] == 0) {
                    EasyLoading.showToast('切换语言成功');
                    model.currentLanguageCode = [languageCode, countryCode];
                    model.currentLanguage = language;
                    model.currentLocale = Locale(languageCode, countryCode);
                    model.appName = appName;
                    model.refresh();
                    SharedUtil.instance.saveStringList(
                        Keys.currentLanguageCode, [languageCode, countryCode]);
                    SharedUtil.instance.saveString(Keys.currentLanguage, language);
                    SharedUtil.instance.saveString(Keys.appName, appName);
                  } else {
                    EasyLoading.showToast(data["message"]);
                  }
                }
              });
            }




          },
          title: new Text(languageDatas[index].language),
        );
      }),
    );
    return FlutterEasyLoading(
      child: new Scaffold(
        appBar: new ComMomBar(title: S.of(context).multiLanguage),
        body: body,
      ),
    );
  }
}

class LanguageData {
  String language;
  String languageCode;
  String countryCode;
  String appName;

  LanguageData(
      this.language, this.languageCode, this.countryCode, this.appName);
}
