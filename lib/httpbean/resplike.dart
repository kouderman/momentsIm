import 'dart:convert';
/// post_likes : 1
/// valid : true
/// message : ""
/// code : 200
/// data : {"like":false}

Resplike resplikeFromJson(String str) => Resplike.fromJson(json.decode(str));
String resplikeToJson(Resplike data) => json.encode(data.toJson());
class Resplike {
  Resplike({
      num postLikes, 
      bool valid, 
      String message, 
      num code, 
      Data data,}){
    _postLikes = postLikes;
    _valid = valid;
    _message = message;
    _code = code;
    _data = data;
}

  Resplike.fromJson(dynamic json) {
    _postLikes = json['post_likes'];
    _valid = json['valid'];
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num _postLikes;
  bool _valid;
  String _message;
  num _code;
  Data _data;
Resplike copyWith({  num postLikes,
  bool valid,
  String message,
  num code,
  Data data,
}) => Resplike(  postLikes: postLikes ?? _postLikes,
  valid: valid ?? _valid,
  message: message ?? _message,
  code: code ?? _code,
  data: data ?? _data,
);
  num get postLikes => _postLikes;
  bool get valid => _valid;
  String get message => _message;
  num get code => _code;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['post_likes'] = _postLikes;
    map['valid'] = _valid;
    map['message'] = _message;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// like : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      bool like,}){
    _like = like;
}

  Data.fromJson(dynamic json) {
    _like = json['like'];
  }
  bool _like;
Data copyWith({  bool like,
}) => Data(  like: like ?? _like,
);
  bool get like => _like;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['like'] = _like;
    return map;
  }

}