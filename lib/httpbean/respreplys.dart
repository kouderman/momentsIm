import 'dart:convert';
/// message : "Replies fetched successfully"
/// code : 200
/// data : [{"id":484,"user_id":1,"text":"新人嫁到","type":"text","replys_count":"0","reposts_count":"0","likes_count":"0","status":"active","thread_id":482,"target":"pub_reply","og_data":"","poll_data":null,"priv_wcs":"everyone","priv_wcr":"everyone","area":"中国内蒙古呼和浩特市中国内蒙古呼和浩特市 电信","ip":"45.116.153.232","item_id":"","time":"4 小时 前","replys":[],"advertising":false,"time_raw":"1664776720","og_text":"新人嫁到","og_image":"statics/img/logo.png","url":"https://juran.huitouke.cn/thread/484","can_delete":false,"media":[],"is_owner":false,"has_liked":false,"has_saved":false,"has_reposted":false,"is_blocked":false,"me_blocked":false,"can_see":true,"reply_to":{"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg","username":"@eqiq963","name":"dd ss","gender":"M","is_owner":true,"thread_url":"https://juran.huitouke.cn/thread/482"},"owner":{"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","name":"Site Admin","verified":"1"},"offset_id":484},{"id":483,"user_id":1,"text":"风也是你，云也是你","type":"text","replys_count":"0","reposts_count":"0","likes_count":"0","status":"active","thread_id":482,"target":"pub_reply","og_data":"","poll_data":null,"priv_wcs":"everyone","priv_wcr":"everyone","area":"中国内蒙古呼和浩特市中国内蒙古呼和浩特市 电信","ip":"45.116.153.232","item_id":"","time":"4 小时 前","replys":[],"advertising":false,"time_raw":"1664776705","og_text":"风也是你，云也是你","og_image":"statics/img/logo.png","url":"https://juran.huitouke.cn/thread/483","can_delete":false,"media":[],"is_owner":false,"has_liked":false,"has_saved":false,"has_reposted":false,"is_blocked":false,"me_blocked":false,"can_see":true,"reply_to":{"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg","username":"@eqiq963","name":"dd ss","gender":"M","is_owner":true,"thread_url":"https://juran.huitouke.cn/thread/482"},"owner":{"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","name":"Site Admin","verified":"1"},"offset_id":483}]

Respreplys respreplysFromJson(String str) => Respreplys.fromJson(json.decode(str));
String respreplysToJson(Respreplys data) => json.encode(data.toJson());
class Respreplys {
  Respreplys({
      String message, 
      num code, 
      List<Data> data,}){
    _message = message;
    _code = code;
    _data = data;
}

  Respreplys.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  String _message;
  num _code;
  List<Data> _data;
Respreplys copyWith({  String message,
  num code,
  List<Data> data,
}) => Respreplys(  message: message ?? _message,
  code: code ?? _code,
  data: data ?? _data,
);
  String get message => _message;
  num get code => _code;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 484
/// user_id : 1
/// text : "新人嫁到"
/// type : "text"
/// replys_count : "0"
/// reposts_count : "0"
/// likes_count : "0"
/// status : "active"
/// thread_id : 482
/// target : "pub_reply"
/// og_data : ""
/// poll_data : null
/// priv_wcs : "everyone"
/// priv_wcr : "everyone"
/// area : "中国内蒙古呼和浩特市中国内蒙古呼和浩特市 电信"
/// ip : "45.116.153.232"
/// item_id : ""
/// time : "4 小时 前"
/// replys : []
/// advertising : false
/// time_raw : "1664776720"
/// og_text : "新人嫁到"
/// og_image : "statics/img/logo.png"
/// url : "https://juran.huitouke.cn/thread/484"
/// can_delete : false
/// media : []
/// is_owner : false
/// has_liked : false
/// has_saved : false
/// has_reposted : false
/// is_blocked : false
/// me_blocked : false
/// can_see : true
/// reply_to : {"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg","username":"@eqiq963","name":"dd ss","gender":"M","is_owner":true,"thread_url":"https://juran.huitouke.cn/thread/482"}
/// owner : {"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","name":"Site Admin","verified":"1"}
/// offset_id : 484

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num id, 
      num userId, 
      String text, 
      String type, 
      String replysCount, 
      String repostsCount, 
      String likesCount, 
      String status, 
      num threadId, 
      String target, 
      String ogData, 
      dynamic pollData, 
      String privWcs, 
      String privWcr, 
      String area, 
      String ip, 
      String itemId, 
      String time, 
      List<dynamic> replys, 
      bool advertising, 
      String timeRaw, 
      String ogText, 
      String ogImage, 
      String url, 
      bool canDelete, 
      List<dynamic> media, 
      bool isOwner, 
      bool hasLiked, 
      bool hasSaved, 
      bool hasReposted, 
      bool isBlocked, 
      bool meBlocked, 
      bool canSee, 
      ReplyTo replyTo, 
      Owner owner, 
      num offsetId,}){
    _id = id;
    _userId = userId;
    _text = text;
    _type = type;
    _replysCount = replysCount;
    _repostsCount = repostsCount;
    _likesCount = likesCount;
    _status = status;
    _threadId = threadId;
    _target = target;
    _ogData = ogData;
    _pollData = pollData;
    _privWcs = privWcs;
    _privWcr = privWcr;
    _area = area;
    _ip = ip;
    _itemId = itemId;
    _time = time;
    _replys = replys;
    _advertising = advertising;
    _timeRaw = timeRaw;
    _ogText = ogText;
    _ogImage = ogImage;
    _url = url;
    _canDelete = canDelete;
    _media = media;
    _isOwner = isOwner;
    _hasLiked = hasLiked;
    _hasSaved = hasSaved;
    _hasReposted = hasReposted;
    _isBlocked = isBlocked;
    _meBlocked = meBlocked;
    _canSee = canSee;
    _replyTo = replyTo;
    _owner = owner;
    _offsetId = offsetId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _text = json['text'];
    _type = json['type'];
    _replysCount = json['replys_count'];
    _repostsCount = json['reposts_count'];
    _likesCount = json['likes_count'];
    _status = json['status'];
    _threadId = json['thread_id'];
    _target = json['target'];
    _ogData = json['og_data'];
    _pollData = json['poll_data'];
    _privWcs = json['priv_wcs'];
    _privWcr = json['priv_wcr'];
    _area = json['area'];
    _ip = json['ip'];
    _itemId = json['item_id'];
    _time = json['time'];
    if (json['replys'] != null) {
      _replys = [];
      json['replys'].forEach((v) {
        // _replys.add(Dynamic.fromJson(v));
      });
    }
    _advertising = json['advertising'];
    _timeRaw = json['time_raw'];
    _ogText = json['og_text'];
    _ogImage = json['og_image'];
    _url = json['url'];
    _canDelete = json['can_delete'];
    if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        // _media.add(Dynamic.fromJson(v));
      });
    }
    _isOwner = json['is_owner'];
    _hasLiked = json['has_liked'];
    _hasSaved = json['has_saved'];
    _hasReposted = json['has_reposted'];
    _isBlocked = json['is_blocked'];
    _meBlocked = json['me_blocked'];
    _canSee = json['can_see'];
    _replyTo = json['reply_to'] != null ? ReplyTo.fromJson(json['reply_to']) : null;
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _offsetId = json['offset_id'];
  }
  num _id;
  num _userId;
  String _text;
  String _type;
  String _replysCount;
  String _repostsCount;
  String _likesCount;
  String _status;
  num _threadId;
  String _target;
  String _ogData;
  dynamic _pollData;
  String _privWcs;
  String _privWcr;
  String _area;
  String _ip;
  String _itemId;
  String _time;
  List<dynamic> _replys;
  bool _advertising;
  String _timeRaw;
  String _ogText;
  String _ogImage;
  String _url;
  bool _canDelete;
  List<dynamic> _media;
  bool _isOwner;
  bool _hasLiked;
  bool _hasSaved;
  bool _hasReposted;
  bool _isBlocked;
  bool _meBlocked;
  bool _canSee;
  ReplyTo _replyTo;
  Owner _owner;
  num _offsetId;
Data copyWith({  num id,
  num userId,
  String text,
  String type,
  String replysCount,
  String repostsCount,
  String likesCount,
  String status,
  num threadId,
  String target,
  String ogData,
  dynamic pollData,
  String privWcs,
  String privWcr,
  String area,
  String ip,
  String itemId,
  String time,
  List<dynamic> replys,
  bool advertising,
  String timeRaw,
  String ogText,
  String ogImage,
  String url,
  bool canDelete,
  List<dynamic> media,
  bool isOwner,
  bool hasLiked,
  bool hasSaved,
  bool hasReposted,
  bool isBlocked,
  bool meBlocked,
  bool canSee,
  ReplyTo replyTo,
  Owner owner,
  num offsetId,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  text: text ?? _text,
  type: type ?? _type,
  replysCount: replysCount ?? _replysCount,
  repostsCount: repostsCount ?? _repostsCount,
  likesCount: likesCount ?? _likesCount,
  status: status ?? _status,
  threadId: threadId ?? _threadId,
  target: target ?? _target,
  ogData: ogData ?? _ogData,
  pollData: pollData ?? _pollData,
  privWcs: privWcs ?? _privWcs,
  privWcr: privWcr ?? _privWcr,
  area: area ?? _area,
  ip: ip ?? _ip,
  itemId: itemId ?? _itemId,
  time: time ?? _time,
  replys: replys ?? _replys,
  advertising: advertising ?? _advertising,
  timeRaw: timeRaw ?? _timeRaw,
  ogText: ogText ?? _ogText,
  ogImage: ogImage ?? _ogImage,
  url: url ?? _url,
  canDelete: canDelete ?? _canDelete,
  media: media ?? _media,
  isOwner: isOwner ?? _isOwner,
  hasLiked: hasLiked ?? _hasLiked,
  hasSaved: hasSaved ?? _hasSaved,
  hasReposted: hasReposted ?? _hasReposted,
  isBlocked: isBlocked ?? _isBlocked,
  meBlocked: meBlocked ?? _meBlocked,
  canSee: canSee ?? _canSee,
  replyTo: replyTo ?? _replyTo,
  owner: owner ?? _owner,
  offsetId: offsetId ?? _offsetId,
);
  num get id => _id;
  num get userId => _userId;
  String get text => _text;
  String get type => _type;
  String get replysCount => _replysCount;
  String get repostsCount => _repostsCount;
  String get likesCount => _likesCount;
  String get status => _status;
  num get threadId => _threadId;
  String get target => _target;
  String get ogData => _ogData;
  dynamic get pollData => _pollData;
  String get privWcs => _privWcs;
  String get privWcr => _privWcr;
  String get area => _area;
  String get ip => _ip;
  String get itemId => _itemId;
  String get time => _time;
  List<dynamic> get replys => _replys;
  bool get advertising => _advertising;
  String get timeRaw => _timeRaw;
  String get ogText => _ogText;
  String get ogImage => _ogImage;
  String get url => _url;
  bool get canDelete => _canDelete;
  List<dynamic> get media => _media;
  bool get isOwner => _isOwner;
  bool get hasLiked => _hasLiked;
  bool get hasSaved => _hasSaved;
  bool get hasReposted => _hasReposted;
  bool get isBlocked => _isBlocked;
  bool get meBlocked => _meBlocked;
  bool get canSee => _canSee;
  ReplyTo get replyTo => _replyTo;
  Owner get owner => _owner;
  num get offsetId => _offsetId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['text'] = _text;
    map['type'] = _type;
    map['replys_count'] = _replysCount;
    map['reposts_count'] = _repostsCount;
    map['likes_count'] = _likesCount;
    map['status'] = _status;
    map['thread_id'] = _threadId;
    map['target'] = _target;
    map['og_data'] = _ogData;
    map['poll_data'] = _pollData;
    map['priv_wcs'] = _privWcs;
    map['priv_wcr'] = _privWcr;
    map['area'] = _area;
    map['ip'] = _ip;
    map['item_id'] = _itemId;
    map['time'] = _time;
    if (_replys != null) {
      map['replys'] = _replys.map((v) => v.toJson()).toList();
    }
    map['advertising'] = _advertising;
    map['time_raw'] = _timeRaw;
    map['og_text'] = _ogText;
    map['og_image'] = _ogImage;
    map['url'] = _url;
    map['can_delete'] = _canDelete;
    if (_media != null) {
      map['media'] = _media.map((v) => v.toJson()).toList();
    }
    map['is_owner'] = _isOwner;
    map['has_liked'] = _hasLiked;
    map['has_saved'] = _hasSaved;
    map['has_reposted'] = _hasReposted;
    map['is_blocked'] = _isBlocked;
    map['me_blocked'] = _meBlocked;
    map['can_see'] = _canSee;
    if (_replyTo != null) {
      map['reply_to'] = _replyTo.toJson();
    }
    if (_owner != null) {
      map['owner'] = _owner.toJson();
    }
    map['offset_id'] = _offsetId;
    return map;
  }

}

/// id : 1
/// url : "https://juran.huitouke.cn/@demoUser"
/// avatar : "http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png"
/// username : "@demoUser"
/// name : "Site Admin"
/// verified : "1"

Owner ownerFromJson(String str) => Owner.fromJson(json.decode(str));
String ownerToJson(Owner data) => json.encode(data.toJson());
class Owner {
  Owner({
      num id, 
      String url, 
      String avatar, 
      String username, 
      String name, 
      String verified,}){
    _id = id;
    _url = url;
    _avatar = avatar;
    _username = username;
    _name = name;
    _verified = verified;
}

  Owner.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
    _avatar = json['avatar'];
    _username = json['username'];
    _name = json['name'];
    _verified = json['verified'];
  }
  num _id;
  String _url;
  String _avatar;
  String _username;
  String _name;
  String _verified;
Owner copyWith({  num id,
  String url,
  String avatar,
  String username,
  String name,
  String verified,
}) => Owner(  id: id ?? _id,
  url: url ?? _url,
  avatar: avatar ?? _avatar,
  username: username ?? _username,
  name: name ?? _name,
  verified: verified ?? _verified,
);
  num get id => _id;
  String get url => _url;
  String get avatar => _avatar;
  String get username => _username;
  String get name => _name;
  String get verified => _verified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    map['avatar'] = _avatar;
    map['username'] = _username;
    map['name'] = _name;
    map['verified'] = _verified;
    return map;
  }

}

/// id : 113
/// url : "https://juran.huitouke.cn/@eqiq963"
/// avatar : "https://juran.huitouke.cn/upload/images/2022/09/j9F8d7eYTHIzStqrrP3H_29_d9167bb10bbfa1a06a513dee3e9f133e_image_300x300.jpg"
/// username : "@eqiq963"
/// name : "dd ss"
/// gender : "M"
/// is_owner : true
/// thread_url : "https://juran.huitouke.cn/thread/482"

ReplyTo replyToFromJson(String str) => ReplyTo.fromJson(json.decode(str));
String replyToToJson(ReplyTo data) => json.encode(data.toJson());
class ReplyTo {
  ReplyTo({
      num id, 
      String url, 
      String avatar, 
      String username, 
      String name, 
      String gender, 
      bool isOwner, 
      String threadUrl,}){
    _id = id;
    _url = url;
    _avatar = avatar;
    _username = username;
    _name = name;
    _gender = gender;
    _isOwner = isOwner;
    _threadUrl = threadUrl;
}

  ReplyTo.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
    _avatar = json['avatar'];
    _username = json['username'];
    _name = json['name'];
    _gender = json['gender'];
    _isOwner = json['is_owner'];
    _threadUrl = json['thread_url'];
  }
  num _id;
  String _url;
  String _avatar;
  String _username;
  String _name;
  String _gender;
  bool _isOwner;
  String _threadUrl;
ReplyTo copyWith({  num id,
  String url,
  String avatar,
  String username,
  String name,
  String gender,
  bool isOwner,
  String threadUrl,
}) => ReplyTo(  id: id ?? _id,
  url: url ?? _url,
  avatar: avatar ?? _avatar,
  username: username ?? _username,
  name: name ?? _name,
  gender: gender ?? _gender,
  isOwner: isOwner ?? _isOwner,
  threadUrl: threadUrl ?? _threadUrl,
);
  num get id => _id;
  String get url => _url;
  String get avatar => _avatar;
  String get username => _username;
  String get name => _name;
  String get gender => _gender;
  bool get isOwner => _isOwner;
  String get threadUrl => _threadUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    map['avatar'] = _avatar;
    map['username'] = _username;
    map['name'] = _name;
    map['gender'] = _gender;
    map['is_owner'] = _isOwner;
    map['thread_url'] = _threadUrl;
    return map;
  }

}