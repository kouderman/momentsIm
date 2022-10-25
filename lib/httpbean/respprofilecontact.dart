import 'dart:convert';
/// code : 200
/// message : "Profile fetched successfully"
/// data : {"id":102,"first_name":"金","last_name":"阳光","user_name":"guog","name":"金 阳光","avatar":"https://juran.huitouke.cn/upload/images/2022/09/udXzGq3ZTUZx33gHBDej_28_309a6f233de9574a4e18877366ed0c00_image_300x300.jpg","email":"as@qq.cn","cover":"https://juran.huitouke.cn/upload/default/cover.png","is_verified":false,"website":"","about_you":"fge4","gender":"F","country":"中国","province":"内蒙古","city":"通辽市","birthday":"2000-01-01","age":22,"post_count":0,"ip_address":"106.40.4.0","following_count":2,"follower_count":1,"language":"china","last_active":"1664457954","profile_privacy":"everyone","member_since":"Sep 2022","is_blocked_visitor":false,"is_following":true,"can_view_profile":true,"user":{"is_blocked_visitor":false,"is_blocked_profile":false,"is_following":false}}

Respprofilecontact respprofilecontactFromJson(String str) => Respprofilecontact.fromJson(json.decode(str));
String respprofilecontactToJson(Respprofilecontact data) => json.encode(data.toJson());
class Respprofilecontact {
  Respprofilecontact({
      int code, 
      String message, 
      Data data,}){
    _code = code;
    _message = message;
    _data = data;
}

  Respprofilecontact.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int _code;
  String _message;
  Data _data;
Respprofilecontact copyWith({  int code,
  String message,
  Data data,
}) => Respprofilecontact(  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
);
  int get code => _code;
  String get message => _message;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// id : 102
/// first_name : "金"
/// last_name : "阳光"
/// user_name : "guog"
/// name : "金 阳光"
/// avatar : "https://juran.huitouke.cn/upload/images/2022/09/udXzGq3ZTUZx33gHBDej_28_309a6f233de9574a4e18877366ed0c00_image_300x300.jpg"
/// email : "as@qq.cn"
/// cover : "https://juran.huitouke.cn/upload/default/cover.png"
/// is_verified : false
/// website : ""
/// about_you : "fge4"
/// gender : "F"
/// country : "中国"
/// province : "内蒙古"
/// city : "通辽市"
/// birthday : "2000-01-01"
/// age : 22
/// post_count : 0
/// ip_address : "106.40.4.0"
/// following_count : 2
/// follower_count : 1
/// language : "china"
/// last_active : "1664457954"
/// profile_privacy : "everyone"
/// member_since : "Sep 2022"
/// is_blocked_visitor : false
/// is_following : true
/// can_view_profile : true
/// user : {"is_blocked_visitor":false,"is_blocked_profile":false,"is_following":false}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int id, 
      String firstName, 
      String lastName, 
      String userName, 
      String name, 
      String avatar, 
      String email, 
      String cover, 
      bool isVerified, 
      String website, 
      String aboutYou, 
      String gender, 
      String country, 
      String province, 
      String city, 
      String birthday, 
      int age, 
      int postCount, 
      String ipAddress, 
      int followingCount, 
      int followerCount, 
      String language, 
      String lastActive, 
      String profilePrivacy, 
      String memberSince, 
      bool isBlockedVisitor, 
      bool isFollowing, 
      bool canViewProfile, 
      User user,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _userName = userName;
    _name = name;
    _avatar = avatar;
    _email = email;
    _cover = cover;
    _isVerified = isVerified;
    _website = website;
    _aboutYou = aboutYou;
    _gender = gender;
    _country = country;
    _province = province;
    _city = city;
    _birthday = birthday;
    _age = age;
    _postCount = postCount;
    _ipAddress = ipAddress;
    _followingCount = followingCount;
    _followerCount = followerCount;
    _language = language;
    _lastActive = lastActive;
    _profilePrivacy = profilePrivacy;
    _memberSince = memberSince;
    _isBlockedVisitor = isBlockedVisitor;
    _isFollowing = isFollowing;
    _canViewProfile = canViewProfile;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _userName = json['user_name'];
    _name = json['name'];
    _avatar = json['avatar'];
    _email = json['email'];
    _cover = json['cover'];
    _isVerified = json['is_verified'];
    _website = json['website'];
    _aboutYou = json['about_you'];
    _gender = json['gender'];
    _country = json['country'];
    _province = json['province'];
    _city = json['city'];
    _birthday = json['birthday'];
    _age = json['age'];
    _postCount = json['post_count'];
    _ipAddress = json['ip_address'];
    _followingCount = json['following_count'];
    _followerCount = json['follower_count'];
    _language = json['language'];
    _lastActive = json['last_active'];
    _profilePrivacy = json['profile_privacy'];
    _memberSince = json['member_since'];
    _isBlockedVisitor = json['is_blocked_visitor'];
    _isFollowing = json['is_following'];
    _canViewProfile = json['can_view_profile'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int _id;
  String _firstName;
  String _lastName;
  String _userName;
  String _name;
  String _avatar;
  String _email;
  String _cover;
  bool _isVerified;
  String _website;
  String _aboutYou;
  String _gender;
  String _country;
  String _province;
  String _city;
  String _birthday;
  int _age;
  int _postCount;
  String _ipAddress;
  int _followingCount;
  int _followerCount;
  String _language;
  String _lastActive;
  String _profilePrivacy;
  String _memberSince;
  bool _isBlockedVisitor;
  bool _isFollowing;
  bool _canViewProfile;
  User _user;
Data copyWith({  int id,
  String firstName,
  String lastName,
  String userName,
  String name,
  String avatar,
  String email,
  String cover,
  bool isVerified,
  String website,
  String aboutYou,
  String gender,
  String country,
  String province,
  String city,
  String birthday,
  int age,
  int postCount,
  String ipAddress,
  int followingCount,
  int followerCount,
  String language,
  String lastActive,
  String profilePrivacy,
  String memberSince,
  bool isBlockedVisitor,
  bool isFollowing,
  bool canViewProfile,
  User user,
}) => Data(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  userName: userName ?? _userName,
  name: name ?? _name,
  avatar: avatar ?? _avatar,
  email: email ?? _email,
  cover: cover ?? _cover,
  isVerified: isVerified ?? _isVerified,
  website: website ?? _website,
  aboutYou: aboutYou ?? _aboutYou,
  gender: gender ?? _gender,
  country: country ?? _country,
  province: province ?? _province,
  city: city ?? _city,
  birthday: birthday ?? _birthday,
  age: age ?? _age,
  postCount: postCount ?? _postCount,
  ipAddress: ipAddress ?? _ipAddress,
  followingCount: followingCount ?? _followingCount,
  followerCount: followerCount ?? _followerCount,
  language: language ?? _language,
  lastActive: lastActive ?? _lastActive,
  profilePrivacy: profilePrivacy ?? _profilePrivacy,
  memberSince: memberSince ?? _memberSince,
  isBlockedVisitor: isBlockedVisitor ?? _isBlockedVisitor,
  isFollowing: isFollowing ?? _isFollowing,
  canViewProfile: canViewProfile ?? _canViewProfile,
  user: user ?? _user,
);
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get userName => _userName;
  String get name => _name;
  String get avatar => _avatar;
  String get email => _email;
  String get cover => _cover;
  bool get isVerified => _isVerified;
  String get website => _website;
  String get aboutYou => _aboutYou;
  String get gender => _gender;
  String get country => _country;
  String get province => _province;
  String get city => _city;
  String get birthday => _birthday;
  int get age => _age;
  int get postCount => _postCount;
  String get ipAddress => _ipAddress;
  int get followingCount => _followingCount;
  int get followerCount => _followerCount;
  String get language => _language;
  String get lastActive => _lastActive;
  String get profilePrivacy => _profilePrivacy;
  String get memberSince => _memberSince;
  bool get isBlockedVisitor => _isBlockedVisitor;
  bool get isFollowing => _isFollowing;
  bool get canViewProfile => _canViewProfile;
  User get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['user_name'] = _userName;
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['email'] = _email;
    map['cover'] = _cover;
    map['is_verified'] = _isVerified;
    map['website'] = _website;
    map['about_you'] = _aboutYou;
    map['gender'] = _gender;
    map['country'] = _country;
    map['province'] = _province;
    map['city'] = _city;
    map['birthday'] = _birthday;
    map['age'] = _age;
    map['post_count'] = _postCount;
    map['ip_address'] = _ipAddress;
    map['following_count'] = _followingCount;
    map['follower_count'] = _followerCount;
    map['language'] = _language;
    map['last_active'] = _lastActive;
    map['profile_privacy'] = _profilePrivacy;
    map['member_since'] = _memberSince;
    map['is_blocked_visitor'] = _isBlockedVisitor;
    map['is_following'] = _isFollowing;
    map['can_view_profile'] = _canViewProfile;
    if (_user != null) {
      map['user'] = _user.toJson();
    }
    return map;
  }

}

/// is_blocked_visitor : false
/// is_blocked_profile : false
/// is_following : false

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      bool isBlockedVisitor, 
      bool isBlockedProfile, 
      bool isFollowing,}){
    _isBlockedVisitor = isBlockedVisitor;
    _isBlockedProfile = isBlockedProfile;
    _isFollowing = isFollowing;
}

  User.fromJson(dynamic json) {
    _isBlockedVisitor = json['is_blocked_visitor'];
    _isBlockedProfile = json['is_blocked_profile'];
    _isFollowing = json['is_following'];
  }
  bool _isBlockedVisitor;
  bool _isBlockedProfile;
  bool _isFollowing;
User copyWith({  bool isBlockedVisitor,
  bool isBlockedProfile,
  bool isFollowing,
}) => User(  isBlockedVisitor: isBlockedVisitor ?? _isBlockedVisitor,
  isBlockedProfile: isBlockedProfile ?? _isBlockedProfile,
  isFollowing: isFollowing ?? _isFollowing,
);
  bool get isBlockedVisitor => _isBlockedVisitor;
  bool get isBlockedProfile => _isBlockedProfile;
  bool get isFollowing => _isFollowing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_blocked_visitor'] = _isBlockedVisitor;
    map['is_blocked_profile'] = _isBlockedProfile;
    map['is_following'] = _isFollowing;
    return map;
  }

}