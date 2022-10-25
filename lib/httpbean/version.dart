import 'dart:convert';
/// code : 409
/// data : {"url":"https://downloadsource.huitouke.cn/im.apk","option":"mandatory"}
/// message : "Update Please"

Version versionFromJson(String str) => Version.fromJson(json.decode(str));
String versionToJson(Version data) => json.encode(data.toJson());
class Version {
  Version({
      num code, 
      Data data, 
      String message,}){
    _code = code;
    _data = data;
    _message = message;
}

  Version.fromJson(dynamic json) {
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num _code;
  Data _data;
  String _message;
Version copyWith({  num code,
  Data data,
  String message,
}) => Version(  code: code ?? _code,
  data: data ?? _data,
  message: message ?? _message,
);
  num get code => _code;
  Data get data => _data;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// url : "https://downloadsource.huitouke.cn/im.apk"
/// option : "mandatory"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String url, 
      String option,}){
    _url = url;
    _option = option;
}

  Data.fromJson(dynamic json) {
    _url = json['url'];
    _option = json['option'];
  }
  String _url;
  String _option;
Data copyWith({  String url,
  String option,
}) => Data(  url: url ?? _url,
  option: option ?? _option,
);
  String get url => _url;
  String get option => _option;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['option'] = _option;
    return map;
  }

}