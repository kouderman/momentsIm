import 'dart:convert';

import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/im/entity/chat_list_entity.dart';
import 'package:wechat_flutter/im/entity/i_person_info_entity.dart';
import 'package:wechat_flutter/im/entity/message_entity.dart';
import 'package:wechat_flutter/im/entity/person_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/im/conversation_handle.dart';
import 'package:wechat_flutter/im/info_handle.dart';
import 'package:wechat_flutter/im/message_handle.dart';
import 'package:wechat_flutter/main.dart';
import 'package:wechat_flutter/pages/root/UserEvent.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../friend/fun_dim_friend.dart';

class ChatList {
  ChatList({
    @required this.avatar,
    @required this.name,
    @required this.identifier,
    @required this.content,
    @required this.time,
    @required this.type,
    @required this.msgType,
    @required this.unread,
  });

  final String avatar;
  final String name;
  final int time;
  final Map content;
  final String identifier;
  final dynamic type;
  final String msgType;
  final String unread;
}

class ChatListData {
  Future<bool> isNull() async {
    final str = await getConversationsListData();
    List<dynamic> data = json.decode(str);
    return !listNoEmpty(data);
  }

  chatListData() async {
    List<ChatList> chatList = new List<ChatList>();
    String avatar;
    String name;
    int time;
    String identifier;
    dynamic type;
    String msgType;

    String str = await getConversationsListData();
    // LoggerUtil.e(str);
    String nullMap = '{"mConversation":{},"peer":"","type":"System"}';
    str = str.replaceAll(',' + nullMap, '').replaceAll(nullMap + ',', '');
    int icount = 0;
    if (strNoEmpty(str) && str != '[]') {
      List<dynamic> data = json.decode(str);
      // LoggerUtil.e("data   $data");
      for (int i = 0; i < data.length; i++) {
        ChatListEntity model = ChatListEntity.fromJson(data[i]);
        type = model?.type ?? 'C2C';
        identifier = model?.peer ?? '';
        try {
          final profile = await getUsersProfile([model.peer]);
          List<dynamic> profileData = json.decode(profile);
          for (int i = 0; i < profileData.length; i++) {
            if (Platform.isIOS) {
              IPersonInfoEntity info =
              IPersonInfoEntity.fromJson(profileData[i]);

              if (strNoEmpty(info?.faceURL) && info?.faceURL != '[]') {
                avatar = info?.faceURL ?? defIcon;
              } else {
                avatar = defIcon;
              }
              name = strNoEmpty(info?.nickname)
                  ? info?.nickname
                  : identifier ?? '未知';
            } else {
              PersonInfoEntity info = PersonInfoEntity.fromJson(profileData[i]);
              if (strNoEmpty(info?.faceUrl) && info?.faceUrl != '[]') {
                avatar = info?.faceUrl ?? defIcon;
              } else {
                avatar = defIcon;
              }
              name = strNoEmpty(info?.nickName)
                  ? info?.nickName
                  : identifier ?? '未知';
            }
          }
        } catch (e) {}

        final message = await getDimMessages(identifier,
            num: 1, type: type == 'C2C' ? 1 : 2);
        List<dynamic> messageData = new List();

        // LoggerUtil.e(identifier);
        // LoggerUtil.e(message);
        if (strNoEmpty(message) && !message.toString().contains('failed')) {
          messageData = json.decode(message);
        }
        if (listNoEmpty(messageData)) {
          MessageEntity messageModel = MessageEntity.fromJson(messageData[0]);
          time = messageModel?.time ?? 0;
          msgType = messageModel?.message?.type ?? '1';
        }
        if (type == 'Group'){
          var result = await dim.getGroupInfoList([identifier]);
          result =json.decode(result.toString().replaceAll("'", '"'));

          name = result[0]["groupName"].toString();
        }

        int unread = await getUnreadMessageNum(type == 'C2C' ? 1 : 2,identifier);

        icount += unread;
        chatList.insert(
          0,
          new ChatList(
            type: type,
            identifier: identifier,
            avatar: avatar,
            name: name ?? '未知',
            time: time ?? 0,
            content: listNoEmpty(messageData) ? messageData[0] : null,
            msgType: msgType ?? '1',
            unread: unread.toString()
          ),
        );
      }
    }
    // LoggerUtil.e('sendmsg $icount');
    eventBus.fire(UserEvent(count: icount));
    return chatList;
  }
}
