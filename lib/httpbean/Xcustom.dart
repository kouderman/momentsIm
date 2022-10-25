class Xcustom {
  Xcustom({
      this.imageThumb,this.poster_thumb});

  Xcustom.fromJson(dynamic json) {
    imageThumb = json['image_thumb'];
    imageThumb = json['poster_thumb'];
  }
  String imageThumb;
  String poster_thumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_thumb'] = imageThumb;
    map['poster_thumb'] = poster_thumb;
    return map;
  }

}