import 'dart:convert';
/// code : 200
/// valid : true
/// message : "Followers fetched successfully"
/// data : [{"offset_id":94,"id":101,"gender":"F","birthday":"2000-01-01","about":"","following":14,"followers":1,"posts":0,"avatar":"https://juran.huitouke.cn/upload/images/2022/09/lGhRXmpWS6mpSh8vuHjg_28_8797d012e1b3a98622726818f5646bfc_image_300x300.jpg","last_active":"28 Sep, 22 08:09 PM","username":"@usermssdd","fname":"林","lname":"妹妹","email":"asdf@huitouke.cn","verified":"0","follow_privacy":"everyone","province":"内蒙古","city":"通辽市","distance":13398.1,"name":"林 妹妹","age":22,"url":"https://juran.huitouke.cn/@usermssdd","is_following":false,"follow_requested":false,"is_user":false},{"offset_id":87,"id":105,"gender":"F","birthday":"2000-01-01","about":"","following":7,"followers":1,"posts":0,"avatar":"https://juran.huitouke.cn/upload/images/2022/09/PnLQGipc2B46D5Eq5Ean_28_795c531afbe274648137082e645fd03c_image_300x300.jpeg","last_active":"30 Sep, 22 09:09 PM","username":"@eqiq110","fname":"lu","lname":"huashan","email":"asdf@qq.com","verified":"0","follow_privacy":"everyone","province":"湖南","city":"长沙市","distance":13398.1,"name":"lu huashan","age":22,"url":"https://juran.huitouke.cn/@eqiq110","is_following":false,"follow_requested":false,"is_user":false},{"offset_id":85,"id":102,"gender":"F","birthday":"2000-01-01","about":"fge4","following":2,"followers":1,"posts":0,"avatar":"https://juran.huitouke.cn/upload/images/2022/09/udXzGq3ZTUZx33gHBDej_28_309a6f233de9574a4e18877366ed0c00_image_300x300.jpg","last_active":"29 Sep, 22 09:09 PM","username":"@guog","fname":"金","lname":"阳光","email":"gq@huitouke.cn","verified":"0","follow_privacy":"everyone","province":"内蒙古","city":"通辽市","distance":13398.1,"name":"金 阳光","age":22,"url":"https://juran.huitouke.cn/@guog","is_following":false,"follow_requested":false,"is_user":false}]

Resprecommand resprecommandFromJson(String str) => Resprecommand.fromJson(json.decode(str));
String resprecommandToJson(Resprecommand data) => json.encode(data.toJson());
class Resprecommand {
  Resprecommand({
      num code, 
      bool valid, 
      String message, 
      List<Data> data,}){
    _code = code;
    _valid = valid;
    _message = message;
    _data = data;
}

  Resprecommand.fromJson(dynamic json) {
    _code = json['code'];
    _valid = json['valid'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  num _code;
  bool _valid;
  String _message;
  List<Data> _data;
Resprecommand copyWith({  num code,
  bool valid,
  String message,
  List<Data> data,
}) => Resprecommand(  code: code ?? _code,
  valid: valid ?? _valid,
  message: message ?? _message,
  data: data ?? _data,
);
  num get code => _code;
  bool get valid => _valid;
  String get message => _message;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['valid'] = _valid;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// offset_id : 94
/// id : 101
/// gender : "F"
/// birthday : "2000-01-01"
/// about : ""
/// following : 14
/// followers : 1
/// posts : 0
/// avatar : "https://juran.huitouke.cn/upload/images/2022/09/lGhRXmpWS6mpSh8vuHjg_28_8797d012e1b3a98622726818f5646bfc_image_300x300.jpg"
/// last_active : "28 Sep, 22 08:09 PM"
/// username : "@usermssdd"
/// fname : "林"
/// lname : "妹妹"
/// email : "asdf@huitouke.cn"
/// verified : "0"
/// follow_privacy : "everyone"
/// province : "内蒙古"
/// city : "通辽市"
/// distance : 13398.1
/// name : "林 妹妹"
/// age : 22
/// url : "https://juran.huitouke.cn/@usermssdd"
/// is_following : false
/// follow_requested : false
/// is_user : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num offsetId, 
      num id, 
      String gender, 
      String birthday, 
      String about, 
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
      String province, 
      String city, 
      String distance,
      String name, 
      num age, 
      String url, 
      bool isFollowing, 
      bool followRequested, 
      bool isUser,}){
    _offsetId = offsetId;
    _id = id;
    _gender = gender;
    _birthday = birthday;
    _about = about;
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
    _province = province;
    _city = city;
    _distance = distance;
    _name = name;
    _age = age;
    _url = url;
    _isFollowing = isFollowing;
    _followRequested = followRequested;
    _isUser = isUser;
}

  Data.fromJson(dynamic json) {
    _offsetId = json['offset_id'];
    _id = json['id'];
    _gender = json['gender'];
    _birthday = json['birthday'];
    _about = json['about'];
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
    _province = json['province'];
    _city = json['city'];
    _distance = json['distance'].toString();
    _name = json['name'];
    _age = json['age'];
    _url = json['url'];
    _isFollowing = json['is_following'];
    _followRequested = json['follow_requested'];
    _isUser = json['is_user'];
  }
  num _offsetId;
  num _id;
  String _gender;
  String _birthday;
  String _about;
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
  String _province;
  String _city;
  String _distance;
  String _name;
  num _age;
  String _url;
  bool _isFollowing;
  bool _followRequested;
  bool _isUser;
Data copyWith({  num offsetId,
  num id,
  String gender,
  String birthday,
  String about,
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
  String province,
  String city,
  String distance,
  String name,
  num age,
  String url,
  bool isFollowing,
  bool followRequested,
  bool isUser,
}) => Data(  offsetId: offsetId ?? _offsetId,
  id: id ?? _id,
  gender: gender ?? _gender,
  birthday: birthday ?? _birthday,
  about: about ?? _about,
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
  province: province ?? _province,
  city: city ?? _city,
  distance: distance ?? _distance,
  name: name ?? _name,
  age: age ?? _age,
  url: url ?? _url,
  isFollowing: isFollowing ?? _isFollowing,
  followRequested: followRequested ?? _followRequested,
  isUser: isUser ?? _isUser,
);
  num get offsetId => _offsetId;
  num get id => _id;
  String get gender => _gender;
  String get birthday => _birthday;
  String get about => _about;
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
  String get province => _province;
  String get city => _city;
  String get distance => _distance;
  String get name => _name;
  num get age => _age;
  String get url => _url;
  bool get isFollowing => _isFollowing;
  bool get followRequested => _followRequested;
  bool get isUser => _isUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset_id'] = _offsetId;
    map['id'] = _id;
    map['gender'] = _gender;
    map['birthday'] = _birthday;
    map['about'] = _about;
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
    map['province'] = _province;
    map['city'] = _city;
    map['distance'] = _distance;
    map['name'] = _name;
    map['age'] = _age;
    map['url'] = _url;
    map['is_following'] = _isFollowing;
    map['follow_requested'] = _followRequested;
    map['is_user'] = _isUser;
    return map;
  }

}