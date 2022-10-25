import 'dart:convert';
/// err_code : 0
/// message : "Media file uploaded successfully"
/// code : 200
/// data : {"url":"https://juran.huitouke.cn/upload/images/2022/09/oGOoXVvTNsXXlKFzQmuE_25_dd96beb170d06dc8a04b89f9aeab096c_image_300x300.png"}

Respavatar respavatarFromJson(String str) => Respavatar.fromJson(json.decode(str));
String respavatarToJson(Respavatar data) => json.encode(data.toJson());
class Respavatar {
  Respavatar({
      int errCode, 
      String message, 
      int code, 
      Data data,}){
    _errCode = errCode;
    _message = message;
    _code = code;
    _data = data;
}

  Respavatar.fromJson(dynamic json) {
    _errCode = json['err_code'];
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int _errCode;
  String _message;
  int _code;
  Data _data;
Respavatar copyWith({  int errCode,
  String message,
  int code,
  Data data,
}) => Respavatar(  errCode: errCode ?? _errCode,
  message: message ?? _message,
  code: code ?? _code,
  data: data ?? _data,
);
  int get errCode => _errCode;
  String get message => _message;
  int get code => _code;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['err_code'] = _errCode;
    map['message'] = _message;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// url : "https://juran.huitouke.cn/upload/images/2022/09/oGOoXVvTNsXXlKFzQmuE_25_dd96beb170d06dc8a04b89f9aeab096c_image_300x300.png"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String url,}){
    _url = url;
}

  Data.fromJson(dynamic json) {
    _url = json['url'];
  }
  String _url;
Data copyWith({  String url,
}) => Data(  url: url ?? _url,
);
  String get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}