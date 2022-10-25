import 'dart:convert';
/// valid : true
/// code : 200
/// message : "Likes fetched successfully"
/// data : [{"offset_id":98,"id":113,"about":"cvdfffdd41","followers":3,"posts":1,"avatar":"https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg","last_active":"03 Oct, 22 11:10 AM","username":"@eqiq963","fname":"dd","lname":"ss","email":"488455@qq.com","verified":"0","follow_privacy":"everyone","name":"dd ss","url":"https://juran.huitouke.cn/@eqiq963","is_following":false,"follow_requested":false,"is_user":false},{"offset_id":97,"id":1,"about":"可咸可甜","followers":3,"posts":15,"avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","last_active":"03 Oct, 22 11:10 AM","username":"@demoUser","fname":"Site","lname":"Admin","email":"admin@qq.com","verified":"1","follow_privacy":"everyone","name":"Site Admin","url":"https://juran.huitouke.cn/@demoUser","is_following":false,"follow_requested":false,"is_user":false}]

Respfetchlikes respfetchlikesFromJson(String str) => Respfetchlikes.fromJson(json.decode(str));
String respfetchlikesToJson(Respfetchlikes data) => json.encode(data.toJson());
class Respfetchlikes {
  Respfetchlikes({
      bool valid, 
      num code, 
      String message, 
      List<Data> data,}){
    _valid = valid;
    _code = code;
    _message = message;
    _data = data;
}

  Respfetchlikes.fromJson(dynamic json) {
    _valid = json['valid'];
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  bool _valid;
  num _code;
  String _message;
  List<Data> _data;
Respfetchlikes copyWith({  bool valid,
  num code,
  String message,
  List<Data> data,
}) => Respfetchlikes(  valid: valid ?? _valid,
  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
);
  bool get valid => _valid;
  num get code => _code;
  String get message => _message;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['valid'] = _valid;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// offset_id : 98
/// id : 113
/// about : "cvdfffdd41"
/// followers : 3
/// posts : 1
/// avatar : "https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg"
/// last_active : "03 Oct, 22 11:10 AM"
/// username : "@eqiq963"
/// fname : "dd"
/// lname : "ss"
/// email : "488455@qq.com"
/// verified : "0"
/// follow_privacy : "everyone"
/// name : "dd ss"
/// url : "https://juran.huitouke.cn/@eqiq963"
/// is_following : false
/// follow_requested : false
/// is_user : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num offsetId, 
      num id, 
      String about, 
      num followers, 
      num posts, 
      String avatar, 
      String lastActive, 
      String username, 
      String fname, 
      String lname, 
      String email, 
      String verified, 
      String followPrivacy, 
      String name, 
      String url, 
      bool isFollowing, 
      bool followRequested, 
      bool isUser,}){
    _offsetId = offsetId;
    _id = id;
    _about = about;
    _followers = followers;
    _posts = posts;
    _avatar = avatar;
    _lastActive = lastActive;
    _username = username;
    _fname = fname;
    _lname = lname;
    _email = email;
    _verified = verified;
    _followPrivacy = followPrivacy;
    _name = name;
    _url = url;
    _isFollowing = isFollowing;
    _followRequested = followRequested;
    _isUser = isUser;
}

  Data.fromJson(dynamic json) {
    _offsetId = json['offset_id'];
    _id = json['id'];
    _about = json['about'];
    _followers = json['followers'];
    _posts = json['posts'];
    _avatar = json['avatar'];
    _lastActive = json['last_active'];
    _username = json['username'];
    _fname = json['fname'];
    _lname = json['lname'];
    _email = json['email'];
    _verified = json['verified'];
    _followPrivacy = json['follow_privacy'];
    _name = json['name'];
    _url = json['url'];
    _isFollowing = json['is_following'];
    _followRequested = json['follow_requested'];
    _isUser = json['is_user'];
  }
  num _offsetId;
  num _id;
  String _about;
  num _followers;
  num _posts;
  String _avatar;
  String _lastActive;
  String _username;
  String _fname;
  String _lname;
  String _email;
  String _verified;
  String _followPrivacy;
  String _name;
  String _url;
  bool _isFollowing;
  bool _followRequested;
  bool _isUser;
Data copyWith({  num offsetId,
  num id,
  String about,
  num followers,
  num posts,
  String avatar,
  String lastActive,
  String username,
  String fname,
  String lname,
  String email,
  String verified,
  String followPrivacy,
  String name,
  String url,
  bool isFollowing,
  bool followRequested,
  bool isUser,
}) => Data(  offsetId: offsetId ?? _offsetId,
  id: id ?? _id,
  about: about ?? _about,
  followers: followers ?? _followers,
  posts: posts ?? _posts,
  avatar: avatar ?? _avatar,
  lastActive: lastActive ?? _lastActive,
  username: username ?? _username,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  email: email ?? _email,
  verified: verified ?? _verified,
  followPrivacy: followPrivacy ?? _followPrivacy,
  name: name ?? _name,
  url: url ?? _url,
  isFollowing: isFollowing ?? _isFollowing,
  followRequested: followRequested ?? _followRequested,
  isUser: isUser ?? _isUser,
);
  num get offsetId => _offsetId;
  num get id => _id;
  String get about => _about;
  num get followers => _followers;
  num get posts => _posts;
  String get avatar => _avatar;
  String get lastActive => _lastActive;
  String get username => _username;
  String get fname => _fname;
  String get lname => _lname;
  String get email => _email;
  String get verified => _verified;
  String get followPrivacy => _followPrivacy;
  String get name => _name;
  String get url => _url;
  bool get isFollowing => _isFollowing;
  bool get followRequested => _followRequested;
  bool get isUser => _isUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset_id'] = _offsetId;
    map['id'] = _id;
    map['about'] = _about;
    map['followers'] = _followers;
    map['posts'] = _posts;
    map['avatar'] = _avatar;
    map['last_active'] = _lastActive;
    map['username'] = _username;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['email'] = _email;
    map['verified'] = _verified;
    map['follow_privacy'] = _followPrivacy;
    map['name'] = _name;
    map['url'] = _url;
    map['is_following'] = _isFollowing;
    map['follow_requested'] = _followRequested;
    map['is_user'] = _isUser;
    return map;
  }

}