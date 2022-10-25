import 'dart:convert';
/// code : 200
/// message : "Profile fetched successfully"
/// data : {"id":113,"first_name":"dd","last_name":"ss","user_name":"eqiq963","name":"dd ss","avatar":"https://juran.huitouke.cn/upload/images/2022/09/6tp2axWHVIZPr7zsKQ9P_29_9c5184b45772caf8d88c9a62ab9df4ad_image_300x300.jpg","email":"488455@qq.com","cover":"https://juran.huitouke.cn/upload/default/cover.png","is_verified":false,"website":"","about_you":"cvdfffdd","gender":"M","country":"中国","province":"河北","city":"唐山市","birthday":"2009-9-29","age":13,"post_count":0,"ip_address":"183.215.38.166","following_count":2,"follower_count":3,"language":"china","last_active":"1664435240","profile_privacy":"everyone","member_since":"Sep 2022","is_blocked_visitor":false,"is_following":false,"can_view_profile":true}

Respprofile respprofileFromJson(String str) => Respprofile.fromJson(json.decode(str));
String respprofileToJson(Respprofile data) => json.encode(data.toJson());
class Respprofile {
  Respprofile({
      int code, 
      String message, 
      Data data,}){
    _code = code;
    _message = message;
    _data = data;
}

  Respprofile.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int _code;
  String _message;
  Data _data;
Respprofile copyWith({  int code,
  String message,
  Data data,
}) => Respprofile(  code: code ?? _code,
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

/// id : 113
/// first_name : "dd"
/// last_name : "ss"
/// user_name : "eqiq963"
/// name : "dd ss"
/// avatar : "https://juran.huitouke.cn/upload/images/2022/09/6tp2axWHVIZPr7zsKQ9P_29_9c5184b45772caf8d88c9a62ab9df4ad_image_300x300.jpg"
/// email : "488455@qq.com"
/// cover : "https://juran.huitouke.cn/upload/default/cover.png"
/// is_verified : false
/// website : ""
/// about_you : "cvdfffdd"
/// gender : "M"
/// country : "中国"
/// province : "河北"
/// city : "唐山市"
/// birthday : "2009-9-29"
/// age : 13
/// post_count : 0
/// ip_address : "183.215.38.166"
/// following_count : 2
/// follower_count : 3
/// language : "china"
/// last_active : "1664435240"
/// profile_privacy : "everyone"
/// member_since : "Sep 2022"
/// is_blocked_visitor : false
/// is_following : false
/// can_view_profile : true

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
      bool canViewProfile,}){
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


  set id(int value) {
    _id = value;
  }

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
    return map;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set userName(String value) {
    _userName = value;
  }

  set name(String value) {
    _name = value;
  }

  set avatar(String value) {
    _avatar = value;
  }

  set email(String value) {
    _email = value;
  }

  set cover(String value) {
    _cover = value;
  }

  set isVerified(bool value) {
    _isVerified = value;
  }

  set website(String value) {
    _website = value;
  }

  set aboutYou(String value) {
    _aboutYou = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set country(String value) {
    _country = value;
  }

  set province(String value) {
    _province = value;
  }

  set city(String value) {
    _city = value;
  }

  set birthday(String value) {
    _birthday = value;
  }

  set age(int value) {
    _age = value;
  }

  set postCount(int value) {
    _postCount = value;
  }

  set ipAddress(String value) {
    _ipAddress = value;
  }

  set followingCount(int value) {
    _followingCount = value;
  }

  set followerCount(int value) {
    _followerCount = value;
  }

  set language(String value) {
    _language = value;
  }

  set lastActive(String value) {
    _lastActive = value;
  }

  set profilePrivacy(String value) {
    _profilePrivacy = value;
  }

  set memberSince(String value) {
    _memberSince = value;
  }

  set isBlockedVisitor(bool value) {
    _isBlockedVisitor = value;
  }

  set isFollowing(bool value) {
    _isFollowing = value;
  }

  set canViewProfile(bool value) {
    _canViewProfile = value;
  }
}