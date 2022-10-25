class Itemlike {
  Itemlike({
      this.offsetId, 
      this.id, 
      this.about, 
      this.followers, 
      this.posts, 
      this.avatar, 
      this.lastActive, 
      this.username, 
      this.fname, 
      this.lname, 
      this.email, 
      this.verified, 
      this.followPrivacy, 
      this.name, 
      this.url, 
      this.isFollowing, 
      this.followRequested, 
      this.isUser,});

  Itemlike.fromJson(dynamic json) {
    offsetId = json['offset_id'];
    id = json['id'];
    about = json['about'];
    followers = json['followers'];
    posts = json['posts'];
    avatar = json['avatar'];
    lastActive = json['last_active'];
    username = json['username'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    verified = json['verified'];
    followPrivacy = json['follow_privacy'];
    name = json['name'];
    url = json['url'];
    isFollowing = json['is_following'];
    followRequested = json['follow_requested'];
    isUser = json['is_user'];
  }
  int offsetId;
  int id;
  String about;
  int followers;
  int posts;
  String avatar;
  String lastActive;
  String username;
  String fname;
  String lname;
  String email;
  String verified;
  String followPrivacy;
  String name;
  String url;
  bool isFollowing;
  bool followRequested;
  bool isUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset_id'] = offsetId;
    map['id'] = id;
    map['about'] = about;
    map['followers'] = followers;
    map['posts'] = posts;
    map['avatar'] = avatar;
    map['last_active'] = lastActive;
    map['username'] = username;
    map['fname'] = fname;
    map['lname'] = lname;
    map['email'] = email;
    map['verified'] = verified;
    map['follow_privacy'] = followPrivacy;
    map['name'] = name;
    map['url'] = url;
    map['is_following'] = isFollowing;
    map['follow_requested'] = followRequested;
    map['is_user'] = isUser;
    return map;
  }

}