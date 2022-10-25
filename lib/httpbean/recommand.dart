import 'dart:convert';

/// id : 95
/// about : ""
/// followers : 0
/// posts : 0
/// avatar : "https://juran.huitouke.cn/upload/portrait/default.jpg"
/// lastactive : "25 Sep, 22 02:09 PM"
/// username : "@kefu"
/// fname : "kefu"
/// lname : "kefu"
/// email : "kawayi91888@gmail.com"
/// verified : "0"
/// followprivacy : "everyone"
/// name : "kefu kefu"
/// url : "https://juran.huitouke.cn/@kefu"
/// isuser : false
/// isfollowing : false
/// followrequested : false

class Recommand {
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
  bool isUser;
  bool isFollowing;
  bool followRequested;
  String following;
  String age;
  String gender;
  String province;
  String city;
  String distance;

  Recommand(
      {this.id,
      this.about,
      this.followers,
      this.age,
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
      this.following,
      this.url,
      this.isUser,
      this.isFollowing,
      this.province,
      this.city,
      this.distance,
      this.gender,
      this.followRequested});

  @override
  String toString() {
    return 'Recommand{id: $id, about: $about, followers: $followers, posts: $posts, avatar: $avatar, lastActive: $lastActive, username: $username, fname: $fname, lname: $lname, email: $email, verified: $verified, followPrivacy: $followPrivacy, name: $name, url: $url, isUser: $isUser, isFollowing: $isFollowing, followRequested: $followRequested, following: $following, age: $age, gender: $gender, province: $province, city: $city, distance: $distance}';
  }
}
