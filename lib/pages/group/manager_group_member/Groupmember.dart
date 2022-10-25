class Groupmember {
  Groupmember({
      this.user, 
      this.joinTime, 
      this.nameCard, 
      this.msgFlag, 
      this.msgSeq, 
      this.silenceSeconds, 
      this.tinyId, 
      this.role,});

  Groupmember.fromJson(dynamic json) {
    user = json['user'];
    joinTime = json['joinTime'];
    nameCard = json['nameCard'];
    msgFlag = json['msgFlag'];
    msgSeq = json['msgSeq'];
    silenceSeconds = json['silenceSeconds'];
    tinyId = json['tinyId'];
    role = json['role'];
  }
  String user;
  String joinTime;
  String nameCard;
  String msgFlag;
  String msgSeq;
  String silenceSeconds;
  String tinyId;
  String role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['joinTime'] = joinTime;
    map['nameCard'] = nameCard;
    map['msgFlag'] = msgFlag;
    map['msgSeq'] = msgSeq;
    map['silenceSeconds'] = silenceSeconds;
    map['tinyId'] = tinyId;
    map['role'] = role;
    return map;
  }

}