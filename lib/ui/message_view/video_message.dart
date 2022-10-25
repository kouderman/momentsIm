import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/massage/img_item_container.dart';

import '../../pages/wechat_friends/friendcircle/video_play.dart';

class VideoMessage extends StatefulWidget {
  final String video;
  final String thub;

  VideoMessage(this.video,{this.thub});

  @override
  _VideoMessageState createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  Widget time() {
    return new Container(
      margin: EdgeInsets.only(right: 200.0, bottom: 5.0),
      alignment: Alignment.bottomRight,
      child: new Text(
        '0:0',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>routePush(VideoApp(src: widget.video,)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ImageView(
            width: 100,
            height: 100,
            img: widget.thub,
          ),
          IconButton(
              icon: Icon(Icons.play_arrow, color: Colors.white),
              onPressed: () {
                print('click');
                routePush(VideoApp(src: widget.video,));
              })
        ],
      ),
    );
  }
}
