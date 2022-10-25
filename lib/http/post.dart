import 'dart:convert';
/// id : 432
/// user_id : 1
/// text : "图文来了"
/// type : "image"
/// replys_count : "0"
/// reposts_count : "0"
/// likes_count : "1"
/// status : "active"
/// thread_id : 0
/// target : "publication"
/// og_data : ""
/// poll_data : null
/// priv_wcs : "everyone"
/// priv_wcr : "everyone"
/// ip : ""
/// lng : ""
/// lat : ""
/// country : ""
/// province : ""
/// city : ""
/// area : "中国内蒙古通辽市中国内蒙古通辽市 电信"
/// address : ""
/// item_id : ""
/// time : "13 天 前"
/// offset_id : 362
/// is_repost : false
/// is_reposter : false
/// attrs : ""
/// advertising : false
/// time_raw : "1664584714"
/// og_text : "图文来了"
/// og_image : "https://juran.huitouke.cn/upload/images/2022/10/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png"
/// url : "https://juran.huitouke.cn/thread/432"
/// can_delete : false
/// media : [{"id":259,"pub_id":432,"type":"image","src":"https://juran.huitouke.cn/upload/images/2022/10/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png","json_data":"{\n    \"image_thumb\": \"https:\\/\\/juran.huitouke.cn\\/upload\\/images\\/2022\\/10\\/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png\"\n}","time":"1664584706","x":{"image_thumb":"https://juran.huitouke.cn/upload/images/2022/10/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png"}}]
/// is_owner : false
/// has_liked : false
/// has_saved : false
/// has_reposted : false
/// is_blocked : false
/// me_blocked : false
/// can_see : true
/// reply_to : []
/// owner : {"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","gender":"M","age":22,"name":"Site Admin","verified":"1"}

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());
class Post {
  Post({
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
      String ip, 
      String lng, 
      String lat, 
      String country, 
      String province, 
      String city, 
      String area, 
      String address, 
      String itemId, 
      String time, 
      num offsetId, 
      bool isRepost, 
      bool isReposter, 
      String attrs, 
      bool advertising, 
      String timeRaw, 
      String ogText, 
      String ogImage, 
      String url, 
      bool canDelete, 
      List<Media> media, 
      bool isOwner, 
      bool hasLiked, 
      bool hasSaved, 
      bool hasReposted, 
      bool isBlocked, 
      bool meBlocked, 
      bool canSee, 
      List<dynamic> replyTo, 
      Owner owner,}){
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
    _ip = ip;
    _lng = lng;
    _lat = lat;
    _country = country;
    _province = province;
    _city = city;
    _area = area;
    _address = address;
    _itemId = itemId;
    _time = time;
    _offsetId = offsetId;
    _isRepost = isRepost;
    _isReposter = isReposter;
    _attrs = attrs;
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
}

  Post.fromJson(dynamic json) {
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
    _ip = json['ip'];
    _lng = json['lng'];
    _lat = json['lat'];
    _country = json['country'];
    _province = json['province'];
    _city = json['city'];
    _area = json['area'];
    _address = json['address'];
    _itemId = json['item_id'];
    _time = json['time'];
    _offsetId = json['offset_id'];
    _isRepost = json['is_repost'];
    _isReposter = json['is_reposter'];
    _attrs = json['attrs'];
    _advertising = json['advertising'];
    _timeRaw = json['time_raw'];
    _ogText = json['og_text'];
    _ogImage = json['og_image'];
    _url = json['url'];
    _canDelete = json['can_delete'];
    if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        _media.add(Media.fromJson(v));
      });
    }
    _isOwner = json['is_owner'];
    _hasLiked = json['has_liked'];
    _hasSaved = json['has_saved'];
    _hasReposted = json['has_reposted'];
    _isBlocked = json['is_blocked'];
    _meBlocked = json['me_blocked'];
    _canSee = json['can_see'];
    if (json['reply_to'] != null) {
      _replyTo = [];
      json['reply_to'].forEach((v) {
        // _replyTo.add(Dynamic.fromJson(v));
      });
    }
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
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
  String _ip;
  String _lng;
  String _lat;
  String _country;
  String _province;
  String _city;
  String _area;
  String _address;
  String _itemId;
  String _time;
  num _offsetId;
  bool _isRepost;
  bool _isReposter;
  String _attrs;
  bool _advertising;
  String _timeRaw;
  String _ogText;
  String _ogImage;
  String _url;
  bool _canDelete;
  List<Media> _media;
  bool _isOwner;
  bool _hasLiked;
  bool _hasSaved;
  bool _hasReposted;
  bool _isBlocked;
  bool _meBlocked;
  bool _canSee;
  List<dynamic> _replyTo;
  Owner _owner;
Post copyWith({  num id,
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
  String ip,
  String lng,
  String lat,
  String country,
  String province,
  String city,
  String area,
  String address,
  String itemId,
  String time,
  num offsetId,
  bool isRepost,
  bool isReposter,
  String attrs,
  bool advertising,
  String timeRaw,
  String ogText,
  String ogImage,
  String url,
  bool canDelete,
  List<Media> media,
  bool isOwner,
  bool hasLiked,
  bool hasSaved,
  bool hasReposted,
  bool isBlocked,
  bool meBlocked,
  bool canSee,
  List<dynamic> replyTo,
  Owner owner,
}) => Post(  id: id ?? _id,
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
  ip: ip ?? _ip,
  lng: lng ?? _lng,
  lat: lat ?? _lat,
  country: country ?? _country,
  province: province ?? _province,
  city: city ?? _city,
  area: area ?? _area,
  address: address ?? _address,
  itemId: itemId ?? _itemId,
  time: time ?? _time,
  offsetId: offsetId ?? _offsetId,
  isRepost: isRepost ?? _isRepost,
  isReposter: isReposter ?? _isReposter,
  attrs: attrs ?? _attrs,
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
  String get ip => _ip;
  String get lng => _lng;
  String get lat => _lat;
  String get country => _country;
  String get province => _province;
  String get city => _city;
  String get area => _area;
  String get address => _address;
  String get itemId => _itemId;
  String get time => _time;
  num get offsetId => _offsetId;
  bool get isRepost => _isRepost;
  bool get isReposter => _isReposter;
  String get attrs => _attrs;
  bool get advertising => _advertising;
  String get timeRaw => _timeRaw;
  String get ogText => _ogText;
  String get ogImage => _ogImage;
  String get url => _url;
  bool get canDelete => _canDelete;
  List<Media> get media => _media;
  bool get isOwner => _isOwner;
  bool get hasLiked => _hasLiked;
  bool get hasSaved => _hasSaved;
  bool get hasReposted => _hasReposted;
  bool get isBlocked => _isBlocked;
  bool get meBlocked => _meBlocked;
  bool get canSee => _canSee;
  List<dynamic> get replyTo => _replyTo;
  Owner get owner => _owner;

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
    map['ip'] = _ip;
    map['lng'] = _lng;
    map['lat'] = _lat;
    map['country'] = _country;
    map['province'] = _province;
    map['city'] = _city;
    map['area'] = _area;
    map['address'] = _address;
    map['item_id'] = _itemId;
    map['time'] = _time;
    map['offset_id'] = _offsetId;
    map['is_repost'] = _isRepost;
    map['is_reposter'] = _isReposter;
    map['attrs'] = _attrs;
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
      map['reply_to'] = _replyTo.map((v) => v.toJson()).toList();
    }
    if (_owner != null) {
      map['owner'] = _owner.toJson();
    }
    return map;
  }

}

/// id : 1
/// url : "https://juran.huitouke.cn/@demoUser"
/// avatar : "http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png"
/// username : "@demoUser"
/// gender : "M"
/// age : 22
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
      String gender, 
      num age, 
      String name, 
      String verified,}){
    _id = id;
    _url = url;
    _avatar = avatar;
    _username = username;
    _gender = gender;
    _age = age;
    _name = name;
    _verified = verified;
}

  Owner.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
    _avatar = json['avatar'];
    _username = json['username'];
    _gender = json['gender'];
    _age = json['age'];
    _name = json['name'];
    _verified = json['verified'];
  }
  num _id;
  String _url;
  String _avatar;
  String _username;
  String _gender;
  num _age;
  String _name;
  String _verified;
Owner copyWith({  num id,
  String url,
  String avatar,
  String username,
  String gender,
  num age,
  String name,
  String verified,
}) => Owner(  id: id ?? _id,
  url: url ?? _url,
  avatar: avatar ?? _avatar,
  username: username ?? _username,
  gender: gender ?? _gender,
  age: age ?? _age,
  name: name ?? _name,
  verified: verified ?? _verified,
);
  num get id => _id;
  String get url => _url;
  String get avatar => _avatar;
  String get username => _username;
  String get gender => _gender;
  num get age => _age;
  String get name => _name;
  String get verified => _verified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    map['avatar'] = _avatar;
    map['username'] = _username;
    map['gender'] = _gender;
    map['age'] = _age;
    map['name'] = _name;
    map['verified'] = _verified;
    return map;
  }

}

/// id : 259
/// pub_id : 432
/// type : "image"
/// src : "https://juran.huitouke.cn/upload/images/2022/10/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png"
/// json_data : "{\n    \"image_thumb\": \"https:\\/\\/juran.huitouke.cn\\/upload\\/images\\/2022\\/10\\/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png\"\n}"
/// time : "1664584706"
/// x : {"image_thumb":"https://juran.huitouke.cn/upload/images/2022/10/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png"}

Media mediaFromJson(String str) => Media.fromJson(json.decode(str));
String mediaToJson(Media data) => json.encode(data.toJson());
class Media {
  Media({
      num id, 
      num pubId, 
      String type, 
      String src, 
      String jsonData, 
      String time, 
      X x,}){
    _id = id;
    _pubId = pubId;
    _type = type;
    _src = src;
    _jsonData = jsonData;
    _time = time;
    _x = x;
}

  Media.fromJson(dynamic json) {
    _id = json['id'];
    _pubId = json['pub_id'];
    _type = json['type'];
    _src = json['src'];
    _jsonData = json['json_data'];
    _time = json['time'];
    _x = json['x'] != null ? X.fromJson(json['x']) : null;
  }
  num _id;
  num _pubId;
  String _type;
  String _src;
  String _jsonData;
  String _time;
  X _x;
Media copyWith({  num id,
  num pubId,
  String type,
  String src,
  String jsonData,
  String time,
  X x,
}) => Media(  id: id ?? _id,
  pubId: pubId ?? _pubId,
  type: type ?? _type,
  src: src ?? _src,
  jsonData: jsonData ?? _jsonData,
  time: time ?? _time,
  x: x ?? _x,
);
  num get id => _id;
  num get pubId => _pubId;
  String get type => _type;
  String get src => _src;
  String get jsonData => _jsonData;
  String get time => _time;
  X get x => _x;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pub_id'] = _pubId;
    map['type'] = _type;
    map['src'] = _src;
    map['json_data'] = _jsonData;
    map['time'] = _time;
    if (_x != null) {
      map['x'] = _x.toJson();
    }
    return map;
  }

}

/// image_thumb : "https://juran.huitouke.cn/upload/images/2022/10/QcWRHf99v4GlG4mORkdc_01_c846326b2e9361066e8ab847e008738f_image_original.png"

X xFromJson(String str) => X.fromJson(json.decode(str));
String xToJson(X data) => json.encode(data.toJson());
class X {
  X({
      String imageThumb,}){
    _imageThumb = imageThumb;
}

  X.fromJson(dynamic json) {
    _imageThumb = json['image_thumb'];
  }
  String _imageThumb;
X copyWith({  String imageThumb,
}) => X(  imageThumb: imageThumb ?? _imageThumb,
);
  String get imageThumb => _imageThumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_thumb'] = _imageThumb;
    return map;
  }

}