import 'dart:convert';
/// replys_total : 1
/// data : {"id":529,"user_id":113,"text":"ddd","type":"text","replys_count":"0","reposts_count":"0","likes_count":"0","status":"active","thread_id":505,"target":"pub_reply","og_data":"","poll_data":null,"priv_wcs":"everyone","priv_wcr":"everyone","area":"","ip":"","item_id":"","time":"刚刚","advertising":false,"time_raw":"1664879101","og_text":"ddd","og_image":"statics/img/logo.png","url":"https://juran.huitouke.cn/thread/529","can_delete":true,"media":[],"is_owner":true,"has_liked":false,"has_saved":false,"has_reposted":false,"is_blocked":false,"me_blocked":false,"can_see":true,"reply_to":{"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/10/9umkW7a7nBMDcZVuOfWP_04_f9a16d0b777e587537cadd6857727708_image_300x300.png","username":"@eqiq963","name":"dd ss","gender":"M","is_owner":true,"thread_url":"https://juran.huitouke.cn/thread/505"},"owner":{"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/10/9umkW7a7nBMDcZVuOfWP_04_f9a16d0b777e587537cadd6857727708_image_300x300.png","username":"@eqiq963","name":"dd ss","verified":"0"},"offset_id":529}
/// code : 200
/// message : "Post published successfully"

Resppublishdetailpost resppublishdetailpostFromJson(String str) => Resppublishdetailpost.fromJson(json.decode(str));
String resppublishdetailpostToJson(Resppublishdetailpost data) => json.encode(data.toJson());
class Resppublishdetailpost {
  Resppublishdetailpost({
      num replysTotal, 
      Data data, 
      num code, 
      String message,}){
    _replysTotal = replysTotal;
    _data = data;
    _code = code;
    _message = message;
}

  Resppublishdetailpost.fromJson(dynamic json) {
    _replysTotal = json['replys_total'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _code = json['code'];
    _message = json['message'];
  }
  num _replysTotal;
  Data _data;
  num _code;
  String _message;
Resppublishdetailpost copyWith({  num replysTotal,
  Data data,
  num code,
  String message,
}) => Resppublishdetailpost(  replysTotal: replysTotal ?? _replysTotal,
  data: data ?? _data,
  code: code ?? _code,
  message: message ?? _message,
);
  num get replysTotal => _replysTotal;
  Data get data => _data;
  num get code => _code;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['replys_total'] = _replysTotal;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }

}

/// id : 529
/// user_id : 113
/// text : "ddd"
/// type : "text"
/// replys_count : "0"
/// reposts_count : "0"
/// likes_count : "0"
/// status : "active"
/// thread_id : 505
/// target : "pub_reply"
/// og_data : ""
/// poll_data : null
/// priv_wcs : "everyone"
/// priv_wcr : "everyone"
/// area : ""
/// ip : ""
/// item_id : ""
/// time : "刚刚"
/// advertising : false
/// time_raw : "1664879101"
/// og_text : "ddd"
/// og_image : "statics/img/logo.png"
/// url : "https://juran.huitouke.cn/thread/529"
/// can_delete : true
/// media : []
/// is_owner : true
/// has_liked : false
/// has_saved : false
/// has_reposted : false
/// is_blocked : false
/// me_blocked : false
/// can_see : true
/// reply_to : {"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/10/9umkW7a7nBMDcZVuOfWP_04_f9a16d0b777e587537cadd6857727708_image_300x300.png","username":"@eqiq963","name":"dd ss","gender":"M","is_owner":true,"thread_url":"https://juran.huitouke.cn/thread/505"}
/// owner : {"id":113,"url":"https://juran.huitouke.cn/@eqiq963","avatar":"https://juran.huitouke.cn/upload/images/2022/10/9umkW7a7nBMDcZVuOfWP_04_f9a16d0b777e587537cadd6857727708_image_300x300.png","username":"@eqiq963","name":"dd ss","verified":"0"}
/// offset_id : 529

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

/// id : 113
/// url : "https://juran.huitouke.cn/@eqiq963"
/// avatar : "https://juran.huitouke.cn/upload/images/2022/10/9umkW7a7nBMDcZVuOfWP_04_f9a16d0b777e587537cadd6857727708_image_300x300.png"
/// username : "@eqiq963"
/// name : "dd ss"
/// verified : "0"

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
/// avatar : "https://juran.huitouke.cn/upload/images/2022/10/9umkW7a7nBMDcZVuOfWP_04_f9a16d0b777e587537cadd6857727708_image_300x300.png"
/// username : "@eqiq963"
/// name : "dd ss"
/// gender : "M"
/// is_owner : true
/// thread_url : "https://juran.huitouke.cn/thread/505"

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