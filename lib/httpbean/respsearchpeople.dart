import 'dart:convert';
/// valid : true
/// code : 200
/// message : "Results found"
/// data : [{"id":113,"about":"cvdfffdd41","gender":"M","birthday":"2009-9-29","following":1,"followers":3,"posts":1,"avatar":"https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg","last_active":"03 Oct, 22 12:10 PM","username":"@eqiq963","fname":"dd","lname":"ss","email":"488455@qq.com","verified":"0","follow_privacy":"everyone","name":"dd ss","age":13,"url":"https://juran.huitouke.cn/@eqiq963","is_user":false,"is_following":false,"follow_requested":false},{"id":101,"about":"","gender":"F","birthday":"2000-01-01","following":14,"followers":1,"posts":0,"avatar":"https://juran.huitouke.cn/upload/images/2022/09/lGhRXmpWS6mpSh8vuHjg_28_8797d012e1b3a98622726818f5646bfc_image_300x300.jpg","last_active":"28 Sep, 22 08:09 PM","username":"@usermssdd","fname":"林","lname":"妹妹","email":"asdf@huitouke.cn","verified":"0","follow_privacy":"everyone","name":"林 妹妹","age":22,"url":"https://juran.huitouke.cn/@usermssdd","is_user":false,"is_following":false,"follow_requested":false}]

Respsearchpeople respsearchpeopleFromJson(String str) => Respsearchpeople.fromJson(json.decode(str));
String respsearchpeopleToJson(Respsearchpeople data) => json.encode(data.toJson());
class Respsearchpeople {
  Respsearchpeople({
      bool valid, 
      num code, 
      String message, 
      List<Data> data,}){
    _valid = valid;
    _code = code;
    _message = message;
    _data = data;
}

  Respsearchpeople.fromJson(dynamic json) {
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
Respsearchpeople copyWith({  bool valid,
  num code,
  String message,
  List<Data> data,
}) => Respsearchpeople(  valid: valid ?? _valid,
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

/// id : 113
/// about : "cvdfffdd41"
/// gender : "M"
/// birthday : "2009-9-29"
/// following : 1
/// followers : 3
/// posts : 1
/// avatar : "https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg"
/// last_active : "03 Oct, 22 12:10 PM"
/// username : "@eqiq963"
/// fname : "dd"
/// lname : "ss"
/// email : "488455@qq.com"
/// verified : "0"
/// follow_privacy : "everyone"
/// name : "dd ss"
/// age : 13
/// url : "https://juran.huitouke.cn/@eqiq963"
/// is_user : false
/// is_following : false
/// follow_requested : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num id, 
      String about, 
      String gender, 
      String birthday, 
      num following, 
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
      num age, 
      String url, 
      bool isUser, 
      bool isFollowing, 
      bool followRequested,}){
    _id = id;
    _about = about;
    _gender = gender;
    _birthday = birthday;
    _following = following;
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
    _age = age;
    _url = url;
    _isUser = isUser;
    _isFollowing = isFollowing;
    _followRequested = followRequested;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _about = json['about'];
    _gender = json['gender'];
    _birthday = json['birthday'];
    _following = json['following'];
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
    _age = json['age'];
    _url = json['url'];
    _isUser = json['is_user'];
    _isFollowing = json['is_following'];
    _followRequested = json['follow_requested'];
  }
  num _id;
  String _about;
  String _gender;
  String _birthday;
  num _following;
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
  num _age;
  String _url;
  bool _isUser;
  bool _isFollowing;
  bool _followRequested;
Data copyWith({  num id,
  String about,
  String gender,
  String birthday,
  num following,
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
  num age,
  String url,
  bool isUser,
  bool isFollowing,
  bool followRequested,
}) => Data(  id: id ?? _id,
  about: about ?? _about,
  gender: gender ?? _gender,
  birthday: birthday ?? _birthday,
  following: following ?? _following,
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
  age: age ?? _age,
  url: url ?? _url,
  isUser: isUser ?? _isUser,
  isFollowing: isFollowing ?? _isFollowing,
  followRequested: followRequested ?? _followRequested,
);
  num get id => _id;
  String get about => _about;
  String get gender => _gender;
  String get birthday => _birthday;
  num get following => _following;
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
  num get age => _age;
  String get url => _url;
  bool get isUser => _isUser;
  bool get isFollowing => _isFollowing;
  bool get followRequested => _followRequested;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['about'] = _about;
    map['gender'] = _gender;
    map['birthday'] = _birthday;
    map['following'] = _following;
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
    map['age'] = _age;
    map['url'] = _url;
    map['is_user'] = _isUser;
    map['is_following'] = _isFollowing;
    map['follow_requested'] = _followRequested;
    return map;
  }

}