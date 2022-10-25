import 'dart:convert';
/// code : 200
/// message : "Posts fetched successfully"
/// data : {"posts":[{"id":31,"user_id":1,"text":"😍爱你的人，忙完手头的事，马上就会联系你，生怕冷落了你。不爱你的人，忙着忙着就消失了，睡着睡着就去世了，吃着吃着就死在饭桌上了，喝着喝着就送去火葬场了。","type":"image","replys_count":"1","reposts_count":"0","likes_count":"0","status":"active","thread_id":0,"target":"publication","og_data":"","poll_data":null,"priv_wcs":"everyone","priv_wcr":"everyone","area":"","ip":"","item_id":"","time":"2 年 前","offset_id":32,"is_repost":false,"is_reposter":false,"attrs":"","advertising":false,"time_raw":"1616137416","og_text":"😍爱你的人，忙完手头的事，马上就会联系你，生怕冷落了你。不爱你的人，忙着忙着就消失了，睡着睡着就去世了，吃着吃着就死在饭桌上了，喝着喝着就送去火葬场了。","og_image":"https://juran.huitouke.cn/upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg","url":"https://juran.huitouke.cn/thread/31","can_delete":false,"media":[{"id":19,"pub_id":31,"type":"image","src":"upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg","json_data":"{\n    \"image_thumb\": \"upload\\/images\\/2021\\/03\\/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg\"\n}","time":"1616137411","x":{"image_thumb":"upload/images/2021/03/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg"}}],"is_owner":false,"has_liked":false,"has_saved":false,"has_reposted":false,"is_blocked":false,"me_blocked":false,"can_see":true,"reply_to":[],"owner":{"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","name":"Site Admin","verified":"1"}}]}

Resppost resppostFromJson(String str) => Resppost.fromJson(json.decode(str));
String resppostToJson(Resppost data) => json.encode(data.toJson());
class Resppost {
  Resppost({
      int code, 
      String message, 
      Data data,}){
    _code = code;
    _message = message;
    _data = data;
}

  Resppost.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int _code;
  String _message;
  Data _data;
Resppost copyWith({  int code,
  String message,
  Data data,
}) => Resppost(  code: code ?? _code,
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

/// posts : [{"id":31,"user_id":1,"text":"😍爱你的人，忙完手头的事，马上就会联系你，生怕冷落了你。不爱你的人，忙着忙着就消失了，睡着睡着就去世了，吃着吃着就死在饭桌上了，喝着喝着就送去火葬场了。","type":"image","replys_count":"1","reposts_count":"0","likes_count":"0","status":"active","thread_id":0,"target":"publication","og_data":"","poll_data":null,"priv_wcs":"everyone","priv_wcr":"everyone","area":"","ip":"","item_id":"","time":"2 年 前","offset_id":32,"is_repost":false,"is_reposter":false,"attrs":"","advertising":false,"time_raw":"1616137416","og_text":"😍爱你的人，忙完手头的事，马上就会联系你，生怕冷落了你。不爱你的人，忙着忙着就消失了，睡着睡着就去世了，吃着吃着就死在饭桌上了，喝着喝着就送去火葬场了。","og_image":"https://juran.huitouke.cn/upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg","url":"https://juran.huitouke.cn/thread/31","can_delete":false,"media":[{"id":19,"pub_id":31,"type":"image","src":"upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg","json_data":"{\n    \"image_thumb\": \"upload\\/images\\/2021\\/03\\/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg\"\n}","time":"1616137411","x":{"image_thumb":"upload/images/2021/03/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg"}}],"is_owner":false,"has_liked":false,"has_saved":false,"has_reposted":false,"is_blocked":false,"me_blocked":false,"can_see":true,"reply_to":[],"owner":{"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","name":"Site Admin","verified":"1"}}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<Posts> posts,}){
    _posts = posts;
}

  Data.fromJson(dynamic json) {
    if (json['posts'] != null) {
      _posts = [];
      json['posts'].forEach((v) {
        _posts.add(Posts.fromJson(v));
      });
    }
  }
  List<Posts> _posts;
Data copyWith({  List<Posts> posts,
}) => Data(  posts: posts ?? _posts,
);
  List<Posts> get posts => _posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_posts != null) {
      map['posts'] = _posts.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 31
/// user_id : 1
/// text : "😍爱你的人，忙完手头的事，马上就会联系你，生怕冷落了你。不爱你的人，忙着忙着就消失了，睡着睡着就去世了，吃着吃着就死在饭桌上了，喝着喝着就送去火葬场了。"
/// type : "image"
/// replys_count : "1"
/// reposts_count : "0"
/// likes_count : "0"
/// status : "active"
/// thread_id : 0
/// target : "publication"
/// og_data : ""
/// poll_data : null
/// priv_wcs : "everyone"
/// priv_wcr : "everyone"
/// area : ""
/// ip : ""
/// item_id : ""
/// time : "2 年 前"
/// offset_id : 32
/// is_repost : false
/// is_reposter : false
/// attrs : ""
/// advertising : false
/// time_raw : "1616137416"
/// og_text : "😍爱你的人，忙完手头的事，马上就会联系你，生怕冷落了你。不爱你的人，忙着忙着就消失了，睡着睡着就去世了，吃着吃着就死在饭桌上了，喝着喝着就送去火葬场了。"
/// og_image : "https://juran.huitouke.cn/upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg"
/// url : "https://juran.huitouke.cn/thread/31"
/// can_delete : false
/// media : [{"id":19,"pub_id":31,"type":"image","src":"upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg","json_data":"{\n    \"image_thumb\": \"upload\\/images\\/2021\\/03\\/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg\"\n}","time":"1616137411","x":{"image_thumb":"upload/images/2021/03/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg"}}]
/// is_owner : false
/// has_liked : false
/// has_saved : false
/// has_reposted : false
/// is_blocked : false
/// me_blocked : false
/// can_see : true
/// reply_to : []
/// owner : {"id":1,"url":"https://juran.huitouke.cn/@demoUser","avatar":"http://img2.3png.com/13ac94dfd12b3519daf3be4696de98547850.png","username":"@demoUser","name":"Site Admin","verified":"1"}

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));
String postsToJson(Posts data) => json.encode(data.toJson());
class Posts {
  Posts({
      int id, 
      int userId, 
      String text, 
      String type, 
      String replysCount, 
      String repostsCount, 
      String likesCount, 
      String status, 
      int threadId, 
      String target, 
      String ogData, 
      dynamic pollData, 
      String privWcs, 
      String privWcr, 
      String area, 
      String ip, 
      String itemId, 
      String time, 
      int offsetId, 
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
    _area = area;
    _ip = ip;
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

  Posts.fromJson(dynamic json) {
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
  int _id;
  int _userId;
  String _text;
  String _type;
  String _replysCount;
  String _repostsCount;
  String _likesCount;
  String _status;
  int _threadId;
  String _target;
  String _ogData;
  dynamic _pollData;
  String _privWcs;
  String _privWcr;
  String _area;
  String _ip;
  String _itemId;
  String _time;
  int _offsetId;
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
Posts copyWith({  int id,
  int userId,
  String text,
  String type,
  String replysCount,
  String repostsCount,
  String likesCount,
  String status,
  int threadId,
  String target,
  String ogData,
  dynamic pollData,
  String privWcs,
  String privWcr,
  String area,
  String ip,
  String itemId,
  String time,
  int offsetId,
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
}) => Posts(  id: id ?? _id,
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
  int get id => _id;
  int get userId => _userId;
  String get text => _text;
  String get type => _type;
  String get replysCount => _replysCount;
  String get repostsCount => _repostsCount;
  String get likesCount => _likesCount;
  String get status => _status;
  int get threadId => _threadId;
  String get target => _target;
  String get ogData => _ogData;
  dynamic get pollData => _pollData;
  String get privWcs => _privWcs;
  String get privWcr => _privWcr;
  String get area => _area;
  String get ip => _ip;
  String get itemId => _itemId;
  String get time => _time;
  int get offsetId => _offsetId;
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
    map['area'] = _area;
    map['ip'] = _ip;
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
/// name : "Site Admin"
/// verified : "1"

Owner ownerFromJson(String str) => Owner.fromJson(json.decode(str));
String ownerToJson(Owner data) => json.encode(data.toJson());
class Owner {
  Owner({
      int id, 
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
  int _id;
  String _url;
  String _avatar;
  String _username;
  String _name;
  String _verified;
Owner copyWith({  int id,
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
  int get id => _id;
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

/// id : 19
/// pub_id : 31
/// type : "image"
/// src : "upload/images/2021/03/9KMhhkPNcpAdYrHL9qMp_19_9268e35b4eaf6e71d28e6c4d625a920b_image_original.jpg"
/// json_data : "{\n    \"image_thumb\": \"upload\\/images\\/2021\\/03\\/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg\"\n}"
/// time : "1616137411"
/// x : {"image_thumb":"upload/images/2021/03/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg"}

Media mediaFromJson(String str) => Media.fromJson(json.decode(str));
String mediaToJson(Media data) => json.encode(data.toJson());
class Media {
  Media({
      int id, 
      int pubId, 
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
  int _id;
  int _pubId;
  String _type;
  String _src;
  String _jsonData;
  String _time;
  X _x;
Media copyWith({  int id,
  int pubId,
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
  int get id => _id;
  int get pubId => _pubId;
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

/// image_thumb : "upload/images/2021/03/8sx7KqdsFtKgLLUWqn59_19_9268e35b4eaf6e71d28e6c4d625a920b_image_300x300.jpg"

X xFromJson(String str) => X.fromJson(json.decode(str));
String xToJson(X data) => json.encode(data.toJson());
class X {
  X({
      String imageThumb,String poster_thumb}){
    _imageThumb = imageThumb;
    _poster_thumb = poster_thumb;
}

  X.fromJson(dynamic json) {
    _imageThumb = json['image_thumb'];
    _poster_thumb = json['poster_thumb'];
  }
  String _imageThumb;
  String _poster_thumb;
X copyWith({  String imageThumb,String poster_thumb
}) => X(  imageThumb: imageThumb ?? _imageThumb,poster_thumb: poster_thumb??_poster_thumb
);
  String get imageThumb => _imageThumb;
  String get poster_thumb => _poster_thumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['poster_thumb'] = _poster_thumb;
    map['image_thumb'] = _imageThumb;
    return map;
  }

}