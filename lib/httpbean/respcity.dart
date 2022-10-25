import 'dart:convert';
/// err_code : 0
/// code : 200
/// data : {"city_list":[{"name":"呼和浩特市"},{"name":"包头市"},{"name":"赤峰市"},{"name":"兴安盟"},{"name":"通辽市"}]}

Respcity respcityFromJson(String str) => Respcity.fromJson(json.decode(str));
String respcityToJson(Respcity data) => json.encode(data.toJson());
class Respcity {
  Respcity({
      num errCode, 
      num code, 
      Data data,}){
    _errCode = errCode;
    _code = code;
    _data = data;
}

  Respcity.fromJson(dynamic json) {
    _errCode = json['err_code'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num _errCode;
  num _code;
  Data _data;
Respcity copyWith({  num errCode,
  num code,
  Data data,
}) => Respcity(  errCode: errCode ?? _errCode,
  code: code ?? _code,
  data: data ?? _data,
);
  num get errCode => _errCode;
  num get code => _code;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['err_code'] = _errCode;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// city_list : [{"name":"呼和浩特市"},{"name":"包头市"},{"name":"赤峰市"},{"name":"兴安盟"},{"name":"通辽市"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<CityList> cityList,}){
    _cityList = cityList;
}

  Data.fromJson(dynamic json) {
    if (json['city_list'] != null) {
      _cityList = [];
      json['city_list'].forEach((v) {
        _cityList.add(CityList.fromJson(v));
      });
    }
  }
  List<CityList> _cityList;
Data copyWith({  List<CityList> cityList,
}) => Data(  cityList: cityList ?? _cityList,
);
  List<CityList> get cityList => _cityList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cityList != null) {
      map['city_list'] = _cityList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "呼和浩特市"

CityList cityListFromJson(String str) => CityList.fromJson(json.decode(str));
String cityListToJson(CityList data) => json.encode(data.toJson());
class CityList {
  CityList({
      String name,}){
    _name = name;
}

  CityList.fromJson(dynamic json) {
    _name = json['name'];
  }
  String _name;
CityList copyWith({  String name,
}) => CityList(  name: name ?? _name,
);
  String get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}