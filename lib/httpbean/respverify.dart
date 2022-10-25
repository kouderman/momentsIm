import 'dart:convert';
/// code : 409
/// data : {"username":"guo"}
/// message : "Im on duty account"

Respverify respverifyFromJson(String str) => Respverify.fromJson(json.decode(str));
String respverifyToJson(Respverify data) => json.encode(data.toJson());
class Respverify {
  Respverify({
      num code, 
      Data data, 
      String message,}){
    _code = code;
    _data = data;
    _message = message;
}

  Respverify.fromJson(dynamic json) {
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num _code;
  Data _data;
  String _message;
Respverify copyWith({  num code,
  Data data,
  String message,
}) => Respverify(  code: code ?? _code,
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

/// username : "guo"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String username,}){
    _username = username;
}

  Data.fromJson(dynamic json) {
    _username = json['username'];
  }
  String _username;
Data copyWith({  String username,
}) => Data(  username: username ?? _username,
);
  String get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    return map;
  }

}