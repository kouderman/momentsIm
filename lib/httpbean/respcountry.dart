import 'dart:convert';
/// err_code : 0
/// code : 200
/// data : {"country_list":[{"name":"中国"},{"name":"美国"}]}

Respcountry respcountryFromJson(String str) => Respcountry.fromJson(json.decode(str));
String respcountryToJson(Respcountry data) => json.encode(data.toJson());
class Respcountry {
  Respcountry({
      int errCode, 
      int code, 
      Data data,}){
    _errCode = errCode;
    _code = code;
    _data = data;
}

  Respcountry.fromJson(dynamic json) {
    _errCode = json['err_code'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int _errCode;
  int _code;
  Data _data;
Respcountry copyWith({  int errCode,
  int code,
  Data data,
}) => Respcountry(  errCode: errCode ?? _errCode,
  code: code ?? _code,
  data: data ?? _data,
);
  int get errCode => _errCode;
  int get code => _code;
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

/// country_list : [{"name":"中国"},{"name":"美国"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<CountryList> countryList,}){
    _countryList = countryList;
}

  Data.fromJson(dynamic json) {
    if (json['country_list'] != null) {
      _countryList = [];
      json['country_list'].forEach((v) {
        _countryList.add(CountryList.fromJson(v));
      });
    }
  }
  List<CountryList> _countryList;
Data copyWith({  List<CountryList> countryList,
}) => Data(  countryList: countryList ?? _countryList,
);
  List<CountryList> get countryList => _countryList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_countryList != null) {
      map['country_list'] = _countryList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "中国"

CountryList countryListFromJson(String str) => CountryList.fromJson(json.decode(str));
String countryListToJson(CountryList data) => json.encode(data.toJson());
class CountryList {
  CountryList({
      String name,}){
    _name = name;
}

  CountryList.fromJson(dynamic json) {
    _name = json['name'];
  }
  String _name;
CountryList copyWith({  String name,
}) => CountryList(  name: name ?? _name,
);
  String get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}