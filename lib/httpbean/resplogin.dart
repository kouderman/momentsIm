import 'dart:convert';
/// err_code : 0
/// code : 200
/// message : "User logged in successfully"
/// data : {"user":{"user_id":83,"first_name":"1","last_name":"1","user_name":"eqiq110","profile_picture":"https://juran.huitouke.cn/upload/default/default.jpg","cover_picture":"https://juran.huitouke.cn/upload/default/cover.png","email":"4555552@qq.com","is_verified":false,"website":"","about_you":"","gender":"F","country":"United States","post_count":0,"last_post":0,"last_ad":0,"language":"china","following_count":0,"follower_count":0,"wallet":"0.00","ip_address":"113.246.152.118","last_active":"1664000089","member_since":"Sep 2022","profile_privacy":"everyone"}}
/// auth : {"auth_token":"370e43a4a9e035357e1a69fe68dc219852edc1ad16640002181a1618acafb24d22a14aa1362449876c","refresh_token":"3d311fc178129ddb2a5197bb096de90916640002188294674c8a7cc0682a2a71e3addf10a3","auth_token_expiry":1695536218,"sig":"eJwtjMsOgjAQRf*la4NDA3QgcYFLY1BS3RA3xpZmVGothPiI-y6Cu3vPSc6b7dYy6LVnGeMBsNn4SWnbUU0jVrq57dthTq5Vl6NzpFgWRgCCYwo4Gf1w5PXA4zjmADDRjpofSxKOiFEq-hUyQ3rrVMNX5nRfamExl6X0VB3meDbCFqGNiuf1tXGlrKseF*zzBS75M3A_"}

Resplogin resploginFromJson(String str) => Resplogin.fromJson(json.decode(str));
String resploginToJson(Resplogin data) => json.encode(data.toJson());
class Resplogin {
  Resplogin({
      int errCode, 
      int code, 
      String message, 
      Data data, 
      Auth auth,}){
    _errCode = errCode;
    _code = code;
    _message = message;
    _data = data;
    _auth = auth;
}

  Resplogin.fromJson(dynamic json) {
    _errCode = json['err_code'];
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
  }
  int _errCode;
  int _code;
  String _message;
  Data _data;
  Auth _auth;
Resplogin copyWith({  int errCode,
  int code,
  String message,
  Data data,
  Auth auth,
}) => Resplogin(  errCode: errCode ?? _errCode,
  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
  auth: auth ?? _auth,
);
  int get errCode => _errCode;
  int get code => _code;
  String get message => _message;
  Data get data => _data;
  Auth get auth => _auth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['err_code'] = _errCode;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    if (_auth != null) {
      map['auth'] = _auth.toJson();
    }
    return map;
  }

}

/// auth_token : "370e43a4a9e035357e1a69fe68dc219852edc1ad16640002181a1618acafb24d22a14aa1362449876c"
/// refresh_token : "3d311fc178129ddb2a5197bb096de90916640002188294674c8a7cc0682a2a71e3addf10a3"
/// auth_token_expiry : 1695536218
/// sig : "eJwtjMsOgjAQRf*la4NDA3QgcYFLY1BS3RA3xpZmVGothPiI-y6Cu3vPSc6b7dYy6LVnGeMBsNn4SWnbUU0jVrq57dthTq5Vl6NzpFgWRgCCYwo4Gf1w5PXA4zjmADDRjpofSxKOiFEq-hUyQ3rrVMNX5nRfamExl6X0VB3meDbCFqGNiuf1tXGlrKseF*zzBS75M3A_"

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));
String authToJson(Auth data) => json.encode(data.toJson());
class Auth {
  Auth({
      String authToken, 
      String refreshToken, 
      int authTokenExpiry, 
      String sig,}){
    _authToken = authToken;
    _refreshToken = refreshToken;
    _authTokenExpiry = authTokenExpiry;
    _sig = sig;
}

  Auth.fromJson(dynamic json) {
    _authToken = json['auth_token'];
    _refreshToken = json['refresh_token'];
    _authTokenExpiry = json['auth_token_expiry'];
    _sig = json['sig'];
  }
  String _authToken;
  String _refreshToken;
  int _authTokenExpiry;
  String _sig;
Auth copyWith({  String authToken,
  String refreshToken,
  int authTokenExpiry,
  String sig,
}) => Auth(  authToken: authToken ?? _authToken,
  refreshToken: refreshToken ?? _refreshToken,
  authTokenExpiry: authTokenExpiry ?? _authTokenExpiry,
  sig: sig ?? _sig,
);
  String get authToken => _authToken;
  String get refreshToken => _refreshToken;
  int get authTokenExpiry => _authTokenExpiry;
  String get sig => _sig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_token'] = _authToken;
    map['refresh_token'] = _refreshToken;
    map['auth_token_expiry'] = _authTokenExpiry;
    map['sig'] = _sig;
    return map;
  }

}

/// user : {"user_id":83,"first_name":"1","last_name":"1","user_name":"eqiq110","profile_picture":"https://juran.huitouke.cn/upload/default/default.jpg","cover_picture":"https://juran.huitouke.cn/upload/default/cover.png","email":"4555552@qq.com","is_verified":false,"website":"","about_you":"","gender":"F","country":"United States","post_count":0,"last_post":0,"last_ad":0,"language":"china","following_count":0,"follower_count":0,"wallet":"0.00","ip_address":"113.246.152.118","last_active":"1664000089","member_since":"Sep 2022","profile_privacy":"everyone"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      User user,}){
    _user = user;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User _user;
Data copyWith({  User user,
}) => Data(  user: user ?? _user,
);
  User get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user.toJson();
    }
    return map;
  }

}

/// user_id : 83
/// first_name : "1"
/// last_name : "1"
/// user_name : "eqiq110"
/// profile_picture : "https://juran.huitouke.cn/upload/default/default.jpg"
/// cover_picture : "https://juran.huitouke.cn/upload/default/cover.png"
/// email : "4555552@qq.com"
/// is_verified : false
/// website : ""
/// about_you : ""
/// gender : "F"
/// country : "United States"
/// post_count : 0
/// last_post : 0
/// last_ad : 0
/// language : "china"
/// following_count : 0
/// follower_count : 0
/// wallet : "0.00"
/// ip_address : "113.246.152.118"
/// last_active : "1664000089"
/// member_since : "Sep 2022"
/// profile_privacy : "everyone"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      int userId, 
      String firstName, 
      String lastName, 
      String userName, 
      String profilePicture, 
      String coverPicture, 
      String email, 
      bool isVerified, 
      String website, 
      String aboutYou, 
      String gender, 
      String country, 
      int postCount, 
      int lastPost, 
      int lastAd, 
      String language, 
      int followingCount, 
      int followerCount, 
      String wallet, 
      String ipAddress, 
      String lastActive, 
      String memberSince, 
      String profilePrivacy,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _userName = userName;
    _profilePicture = profilePicture;
    _coverPicture = coverPicture;
    _email = email;
    _isVerified = isVerified;
    _website = website;
    _aboutYou = aboutYou;
    _gender = gender;
    _country = country;
    _postCount = postCount;
    _lastPost = lastPost;
    _lastAd = lastAd;
    _language = language;
    _followingCount = followingCount;
    _followerCount = followerCount;
    _wallet = wallet;
    _ipAddress = ipAddress;
    _lastActive = lastActive;
    _memberSince = memberSince;
    _profilePrivacy = profilePrivacy;
}

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _userName = json['user_name'];
    _profilePicture = json['profile_picture'];
    _coverPicture = json['cover_picture'];
    _email = json['email'];
    _isVerified = json['is_verified'];
    _website = json['website'];
    _aboutYou = json['about_you'];
    _gender = json['gender'];
    _country = json['country'];
    _postCount = json['post_count'];
    _lastPost = json['last_post'];
    _lastAd = json['last_ad'];
    _language = json['language'];
    _followingCount = json['following_count'];
    _followerCount = json['follower_count'];
    _wallet = json['wallet'];
    _ipAddress = json['ip_address'];
    _lastActive = json['last_active'];
    _memberSince = json['member_since'];
    _profilePrivacy = json['profile_privacy'];
  }
  int _userId;
  String _firstName;
  String _lastName;
  String _userName;
  String _profilePicture;
  String _coverPicture;
  String _email;
  bool _isVerified;
  String _website;
  String _aboutYou;
  String _gender;
  String _country;
  int _postCount;
  int _lastPost;
  int _lastAd;
  String _language;
  int _followingCount;
  int _followerCount;
  String _wallet;
  String _ipAddress;
  String _lastActive;
  String _memberSince;
  String _profilePrivacy;
User copyWith({  int userId,
  String firstName,
  String lastName,
  String userName,
  String profilePicture,
  String coverPicture,
  String email,
  bool isVerified,
  String website,
  String aboutYou,
  String gender,
  String country,
  int postCount,
  int lastPost,
  int lastAd,
  String language,
  int followingCount,
  int followerCount,
  String wallet,
  String ipAddress,
  String lastActive,
  String memberSince,
  String profilePrivacy,
}) => User(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  userName: userName ?? _userName,
  profilePicture: profilePicture ?? _profilePicture,
  coverPicture: coverPicture ?? _coverPicture,
  email: email ?? _email,
  isVerified: isVerified ?? _isVerified,
  website: website ?? _website,
  aboutYou: aboutYou ?? _aboutYou,
  gender: gender ?? _gender,
  country: country ?? _country,
  postCount: postCount ?? _postCount,
  lastPost: lastPost ?? _lastPost,
  lastAd: lastAd ?? _lastAd,
  language: language ?? _language,
  followingCount: followingCount ?? _followingCount,
  followerCount: followerCount ?? _followerCount,
  wallet: wallet ?? _wallet,
  ipAddress: ipAddress ?? _ipAddress,
  lastActive: lastActive ?? _lastActive,
  memberSince: memberSince ?? _memberSince,
  profilePrivacy: profilePrivacy ?? _profilePrivacy,
);
  int get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get userName => _userName;
  String get profilePicture => _profilePicture;
  String get coverPicture => _coverPicture;
  String get email => _email;
  bool get isVerified => _isVerified;
  String get website => _website;
  String get aboutYou => _aboutYou;
  String get gender => _gender;
  String get country => _country;
  int get postCount => _postCount;
  int get lastPost => _lastPost;
  int get lastAd => _lastAd;
  String get language => _language;
  int get followingCount => _followingCount;
  int get followerCount => _followerCount;
  String get wallet => _wallet;
  String get ipAddress => _ipAddress;
  String get lastActive => _lastActive;
  String get memberSince => _memberSince;
  String get profilePrivacy => _profilePrivacy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['user_name'] = _userName;
    map['profile_picture'] = _profilePicture;
    map['cover_picture'] = _coverPicture;
    map['email'] = _email;
    map['is_verified'] = _isVerified;
    map['website'] = _website;
    map['about_you'] = _aboutYou;
    map['gender'] = _gender;
    map['country'] = _country;
    map['post_count'] = _postCount;
    map['last_post'] = _lastPost;
    map['last_ad'] = _lastAd;
    map['language'] = _language;
    map['following_count'] = _followingCount;
    map['follower_count'] = _followerCount;
    map['wallet'] = _wallet;
    map['ip_address'] = _ipAddress;
    map['last_active'] = _lastActive;
    map['member_since'] = _memberSince;
    map['profile_privacy'] = _profilePrivacy;
    return map;
  }

}