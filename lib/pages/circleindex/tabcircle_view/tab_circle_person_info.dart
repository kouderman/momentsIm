import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/pages/chat/chat_page.dart';
import 'package:wechat_flutter/pages/chat/more_info_page.dart';
import 'package:wechat_flutter/pages/chat/set_remark_page.dart';
import 'package:wechat_flutter/pages/wechat_friends/page/wechat_friends_circle.dart';
import 'package:wechat_flutter/provider/global_model.dart';
import 'package:wechat_flutter/ui/dialog/friend_item_dialog.dart';
import 'package:wechat_flutter/ui/item/contact_card.dart';
import 'package:wechat_flutter/ui/orther/button_row.dart';
import 'package:wechat_flutter/ui/orther/label_row.dart';
import 'package:flutter/material.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:provider/provider.dart';

import '../../../config/appdata.dart';
import '../../../http/Method.dart';
import '../../../httpbean/respprofilecontact.dart';
import '../../../tools/sp_util.dart';
import '../../contacts/contact_follow_followed_page/contact_follow_followed_page_view.dart';
import '../../mine/areaevent.dart';
import '../../wechat_friends/friendcircle/friendcircle_view.dart';

class TabContactsDetailsPage extends StatefulWidget {
  String userid;

  TabContactsDetailsPage({this.userid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContactsDetailsPageState(userid);
  }
}

class _ContactsDetailsPageState extends State<TabContactsDetailsPage> {
  final mId;
  EventBus eventBus = EventBus();

  String area = "";
  String gender = "F";
  String count = "朋友圈";
  String following = "关注";
  String follower = "粉丝";
  String uid = "";
  String name = "";

  _ContactsDetailsPageState(this.mId);

  bool isVeried =false;

  List<Widget> body(bool isSelf) {
    return [
      Visibility(
        visible: respProfile != null,
        child: new ContactCard(
          img: respProfile != null ? respProfile.data.avatar : '',
          id: respProfile != null ? respProfile.data.userName.toString() : '',
          about: respProfile != null ? respProfile.data.aboutYou : '',
          title: respProfile != null ? respProfile.data.name.toString() : '',
          nickName: respProfile != null ? respProfile.data.age.toString() : '',
          area: area ?? '',
          isBorder: true,
          gender: gender ?? '',
          isVeried: isVeried,
        ),
      ),
      // new Visibility(
      //   visible: !isSelf,
      //   child: new LabelRow(
      //     label: '设置备注和标签',
      //     onPressed: () => routePush(new SetRemarkPage()),
      //   ),
      // ),
      new Space(),
      new LabelRow(
        label: count,
        isLine: true,
        lineWidth: 0.3,
        onPressed: () => routePush(new FriendcirclePage(
            widget.userid,
            respProfile.data.cover,
            respProfile.data.avatar,
            respProfile.data.name)),
      ),
      new LabelRow(
        label: following,
        isLine: true,
        lineWidth: 0.3,
        onPressed: () => routePush(new Contact_follow_followed_pagePage(
          type: 1,
          userId: widget.userid,
        )),
        // onPressed: () => routePush(new WeChatFriendsCircle()),
      ),
      new LabelRow(
        label: follower,
        isLine: true,
        lineWidth: 0.3,
        onPressed: () => routePush(new Contact_follow_followed_pagePage(
          type: 2,
          userId: widget.userid,
        )),
        // onPressed: () => routePush(new WeChatFriendsCircle()),
      ),
      new LabelRow(
        label: '个性签名',
        onPressed: () => routePush(new MoreInfoPage()),
      ),
      new ButtonRow(
        margin: EdgeInsets.only(top: 10.0),
        text: '发消息',
        isBorder: true,
        onPressed: () => routePushReplace(new ChatPage(
             id: uid.startsWith("@")
    ? uid.substring(1)
        : uid,
            title: name,
            type: 1)),
      ),
      new Visibility(
        visible: false,
        child: new ButtonRow(
          text: '音视频通话',
          onPressed: () => showToast(context, '敬请期待'),
        ),
      ),
    ];
  }

  String id;
  String controlType;

  Respprofilecontact respProfile;

  @override
  void initState() {
    super.initState();
    id = widget.userid;
    LoggerUtil.e('initState $id');

    String authToken = SpUtil.getString("authToken");
    EasyLoading.show(status: '加载中...');
    DioUtil().post('$baseUrl/profile', data: {
      "session_id": authToken,
      "user_id": widget.userid,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      print('Http error code : $statusCode');
    }).then((data) {
      var code = data["code"];
      EasyLoading.dismiss();
      if (code == 200 || code == 0 || code == 201) {
        if (code == 200) {
          respProfile = Respprofilecontact.fromJson(data);
          area = respProfile.data.country +
              " " +
              respProfile.data.province +
              " " +
              respProfile.data.city;
          gender = respProfile.data.gender;

          following = "关注(${respProfile.data.followingCount})";
          follower = "粉丝(${respProfile.data.followerCount})";
          count = "朋友圈(${respProfile.data.postCount})";

          controlType = respProfile.data.user.isFollowing ? "取关" : "关注";

          isVeried = respProfile.data.isVerified;

          uid = respProfile.data.userName;
          name = respProfile.data.name;

          setState(() {});
        }
      } else {
        EasyLoading.dismiss();
      }

      print('Http response: $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    bool isSelf = globalModel.account == widget.userid;

    var rWidget = [
      new SizedBox(
        width: 60,
        child: new FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => friendItemDialog(context,
              mdata: controlType, userId: widget.userid, suCc: (v) {
            if (v) Navigator.of(context).maybePop();
          }, onfollow: (v) {
            follow(widget.userid);
          }, onunfollow: (v) {
            follow(widget.userid);
          }),
          child: new Image.asset(contactAssets + 'ic_contacts_details.png'),
        ),
      )
    ];

    return FlutterEasyLoading(
      child: WillPopScope(
        child: new Scaffold(
          backgroundColor: chatBg,
          appBar: new ComMomBar(
              leadingW: IconButton(
                icon: Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ),
                onPressed: () {
                  LoggerUtil.e('onPressed----------');
                  eventBus.fire(AreaEvent());
                  Navigator.pop(context, true);
                },
              ),
              title: '',
              backgroundColor: Colors.white,
              rightDMActions: isSelf ? [] : rWidget),
          body: new SingleChildScrollView(
            child: new Column(children: body(isSelf)),
          ),
        ),
      ),
    );
  }

  void follow(String sid) {
    String authToken = SpUtil.getString("authToken");
    EasyLoading.show(status: '加载中...');
    DioUtil().post('$baseUrl/follow', data: {
      "session_id": authToken,
      "user_id": widget.userid,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      print('Http error code : $statusCode');
    }).then((data) {
      var code = data["code"];
      EasyLoading.dismiss();
      if (code == 200 || code == 0 || code == 201) {
        if (code == 200) {
          if (controlType == '关注') {
            EasyLoading.showToast("关注成功");
            controlType = "取关";
          } else {
            EasyLoading.showToast("取关成功");
            controlType = "关注";
          }
        }
      } else {
        EasyLoading.dismiss();
      }

      print('Http response: $data');
    });
  }
}
