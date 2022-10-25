import 'dart:convert';
/// err_code : 0
/// message : "Media file uploaded successfully"
/// code : 200
/// data : {"media_id":271,"url":"https://juran.huitouke.cn/upload/images/2022/10/5RuQNOdp6H3CO6selqKG_01_9496f71ae9d54b2a0c462fa3cf45d008_image_300x300.jpg","type":"Image"}

Respuploadmedia respuploadmediaFromJson(String str) => Respuploadmedia.fromJson(json.decode(str));
String respuploadmediaToJson(Respuploadmedia data) => json.encode(data.toJson());
class Respuploadmedia {
  Respuploadmedia({
      int errCode, 
      String message, 
      int code, 
      Data data,}){
    _errCode = errCode;
    _message = message;
    _code = code;
    _data = data;
}

  Respuploadmedia.fromJson(dynamic json) {
    _errCode = json['err_code'];
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int _errCode;
  String _message;
  int _code;
  Data _data;
Respuploadmedia copyWith({  int errCode,
  String message,
  int code,
  Data data,
}) => Respuploadmedia(  errCode: errCode ?? _errCode,
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

/// media_id : 271
/// url : "https://juran.huitouke.cn/upload/images/2022/10/5RuQNOdp6H3CO6selqKG_01_9496f71ae9d54b2a0c462fa3cf45d008_image_300x300.jpg"
/// type : "Image"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int mediaId, 
      String url, 
      String type,}){
    _mediaId = mediaId;
    _url = url;
    _type = type;
}

  Data.fromJson(dynamic json) {
    _mediaId = json['media_id'];
    _url = json['url'];
    _type = json['type'];
  }
  int _mediaId;
  String _url;
  String _type;
Data copyWith({  int mediaId,
  String url,
  String type,
}) => Data(  mediaId: mediaId ?? _mediaId,
  url: url ?? _url,
  type: type ?? _type,
);
  int get mediaId => _mediaId;
  String get url => _url;
  String get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['media_id'] = _mediaId;
    map['url'] = _url;
    map['type'] = _type;
    return map;
  }

}