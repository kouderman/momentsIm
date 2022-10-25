import 'dart:convert';
/// err_code : 0
/// code : 200
/// data : {"province_list":[{"name":"内蒙古"},{"name":"河北"},{"name":"陕西"},{"name":"北京"},{"name":"江苏"},{"name":"浙江"},{"name":"湖南"},{"name":"广东"}]}

Respprovince respprovinceFromJson(String str) => Respprovince.fromJson(json.decode(str));
String respprovinceToJson(Respprovince data) => json.encode(data.toJson());
class Respprovince {
  Respprovince({
      num errCode, 
      num code, 
      Data data,}){
    _errCode = errCode;
    _code = code;
    _data = data;
}

  Respprovince.fromJson(dynamic json) {
    _errCode = json['err_code'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num _errCode;
  num _code;
  Data _data;
Respprovince copyWith({  num errCode,
  num code,
  Data data,
}) => Respprovince(  errCode: errCode ?? _errCode,
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

/// province_list : [{"name":"内蒙古"},{"name":"河北"},{"name":"陕西"},{"name":"北京"},{"name":"江苏"},{"name":"浙江"},{"name":"湖南"},{"name":"广东"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<ProvinceList> provinceList,}){
    _provinceList = provinceList;
}

  Data.fromJson(dynamic json) {
    if (json['province_list'] != null) {
      _provinceList = [];
      json['province_list'].forEach((v) {
        _provinceList.add(ProvinceList.fromJson(v));
      });
    }
  }
  List<ProvinceList> _provinceList;
Data copyWith({  List<ProvinceList> provinceList,
}) => Data(  provinceList: provinceList ?? _provinceList,
);
  List<ProvinceList> get provinceList => _provinceList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_provinceList != null) {
      map['province_list'] = _provinceList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "内蒙古"

ProvinceList provinceListFromJson(String str) => ProvinceList.fromJson(json.decode(str));
String provinceListToJson(ProvinceList data) => json.encode(data.toJson());
class ProvinceList {
  ProvinceList({
      String name,}){
    _name = name;
}

  ProvinceList.fromJson(dynamic json) {
    _name = json['name'];
  }
  String _name;
ProvinceList copyWith({  String name,
}) => ProvinceList(  name: name ?? _name,
);
  String get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}