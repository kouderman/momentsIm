import 'dart:io';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/im/model/chat_data.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/ui/message_view/Img_msg.dart';
import 'package:wechat_flutter/ui/message_view/join_message.dart';
import 'package:wechat_flutter/ui/message_view/modify_groupInfo_message.dart';
import 'package:wechat_flutter/ui/message_view/modify_notification_message.dart';
import 'package:wechat_flutter/ui/message_view/quit_message.dart';
import 'package:wechat_flutter/ui/message_view/red_package.dart';
import 'package:wechat_flutter/ui/message_view/sound_msg.dart';
import 'package:wechat_flutter/ui/message_view/tem_message.dart';
import 'package:wechat_flutter/ui/message_view/text_msg.dart';
import 'package:wechat_flutter/ui/message_view/video_message.dart';

class SendMessageView extends StatefulWidget {
  final ChatData model;

  SendMessageView(this.model);

  @override
  _SendMessageViewState createState() => _SendMessageViewState();
}

class _SendMessageViewState extends State<SendMessageView> {
  @override
  Widget build(BuildContext context) {
    Map msg = widget.model.msg;

    // LoggerUtil.e(msg);
    String msgType = msg['type'];
    String msgStr = msg.toString();

    bool isI = Platform.isIOS;
    bool iosText = isI && msgStr.contains('text:');
    bool iosImg = isI && msgStr.contains('imageList:');
    var iosS = msgStr.contains('downloadFlag:') && msgStr.contains('second:');
    bool iosSound = isI && iosS;
    if ((msgType == "Text" || iosText) &&
        widget.model.msg.toString().contains("测试发送红包消息")) {
      return new RedPackage(widget.model);
    } else if (msgType == "Text" || iosText) {
      return new TextMsg(msg['text'], widget.model);
    } else if (msgType == "Image" || iosImg) {
      return new ImgMsg(msg, widget.model);
    } else if (msgType == 'Sound' || iosSound) {
      return new SoundMsg(widget.model);
    } else if (msg.toString().contains('snapshotPath') &&
        msg.toString().contains('videoPath')) {
      // LoggerUtil.e(msg["videoPath"]);
      return VideoMessage(msg['video']['urls'][0],
          thub: msg['snapshot']['urls'][0]);
    } else if (msgType == 'Location') {
       Map<String, Marker> _markers = <String, Marker>{};
      Marker marker = Marker(icon: BitmapDescriptor.defaultMarkerWithHue(0.0),
          position: LatLng(
              msg["latitude"], msg["longitude"]));
       _markers[marker.id] = marker;
      return Container(
        padding: EdgeInsets.only(left: 50, right: 50,top: 20,bottom: 20),
        width: MediaQuery.of(context).size.width,
        child: Container(
            decoration: new BoxDecoration(
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置四周边框
              border: new Border.all(width: 0.5, color: Colors.white),
            ),
            width: 200,
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: new BoxDecoration(
                      //设置四周圆角 角度
                      //设置四周边框
                      color: Colors.white),
                  alignment: Alignment.center,
                  child: Text(msg['desc']),
                ),
                Container(
                  height: 200,
                  child: AMapWidget(
                      markers: Set<Marker>.of(_markers.values),
                      apiKey: AMapApiKey(

                          iosKey: '',
                          androidKey: 'Amapkey'),
                      privacyStatement: amapPrivacyStatement,
                      initialCameraPosition: CameraPosition(
                          zoom: 15,
                          target: LatLng(msg["latitude"], msg["longitude"]))),
                ),
              ],
            )),
      );
    } else if (msg['tipsType'] == 'Join') {
      return JoinMessage(msg);
    } else if (msg['tipsType'] == 'Quit') {
      return QuitMessage(msg);
    } else if (msg['groupInfoList'][0]['type'] == 'ModifyIntroduction') {
      return ModifyNotificationMessage(msg);
    } else if (msg['groupInfoList'][0]['type'] == 'ModifyName') {
      return ModifyGroupInfoMessage(msg);
    } else {
      return new Text('未知消息');
    }
  }
}
