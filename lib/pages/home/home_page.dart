import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/im/conversation_handle.dart';
import 'package:wechat_flutter/im/model/chat_list.dart';
import 'package:wechat_flutter/pages/chat/chat_page.dart';
import 'package:wechat_flutter/tools/sp_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/view/indicator_page_view.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/ui/edit/text_span_builder.dart';
import 'package:wechat_flutter/ui/chat/my_conversation_view.dart';
import 'package:wechat_flutter/ui/view/pop_view.dart';

import '../../main.dart';
import '../../routerlistener/PageChangeUtil.dart';
import '../../routerlistener/RouteEvent.dart';
import '../../util/AudioPlayerUtil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<ChatList> _chatData = [];

  var tapPos;
  TextSpanBuilder _builder = TextSpanBuilder();
  StreamSubscription<dynamic> _messageStreamSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getChatData();
  }

  Future getChatData() async {
    final str = await ChatListData().chatListData();
    List<ChatList> listChat = str;
    if (!listNoEmpty(listChat)) return;
    _chatData.clear();
    _chatData..addAll(listChat?.reversed);
    if (mounted) setState(() {});
    setState(() {});
  }

  _showMenu(BuildContext context, Offset tapPos, int type, String id) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromLTRB(tapPos.dx, tapPos.dy,
        overlay.size.width - tapPos.dx, overlay.size.height - tapPos.dy);
    showMenu<String>(
        context: context,
        position: position,
        items: <MyPopupMenuItem<String>>[
          new MyPopupMenuItem(child: Text('标为已读'), value: '标为已读'),
          new MyPopupMenuItem(child: Text('置顶聊天'), value: '置顶聊天'),
          new MyPopupMenuItem(child: Text('删除该聊天'), value: '删除该聊天'),
          // ignore: missing_return
        ]).then<String>((String selected) {
      switch (selected) {
        case '删除该聊天':
          deleteConversationAndLocalMsgModel(type, id, callback: (str) {
            debugPrint('deleteConversationAndLocalMsgModel' + str.toString());
          });
          delConversationModel(id, type, callback: (str) {
            debugPrint('deleteConversationModel' + str.toString());
          });
          getChatData();
          break;
        case '标为已读':
          getUnreadMessageNumModel(type, id, callback: (str) {
            int num = int.parse(str.toString());
            if (num != 0) {
              setReadMessageModel(type, id);
              setState(() {});
            }
          });
          break;
        case '置顶聊天':
          LoggerUtil.e(id);
          SpUtil.saveString(id.substring(1), "1");
          break;
      }
    });
  }

  void canCelListener() {
    if (_messageStreamSubscription != null) {
      _messageStreamSubscription.cancel();
    }
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    if (_messageStreamSubscription == null) {
      _messageStreamSubscription = im.onMessage.listen((dynamic onData) {
        getChatData();
        if (onData != null && isListener) {
          AudioPlayerUtil.instance.playLocalSuccess();
        }
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  Widget timeView(int time) {
    DateTime dateTime;
    // LoggerUtil.e(time);
    if (time == 0) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch);
    } else {
      dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    }

    String hourParse = "0${dateTime.hour}";
    String minuteParse = "0${dateTime.minute}";

    String hour = dateTime.hour.toString().length == 1
        ? hourParse
        : dateTime.hour.toString();
    String minute = dateTime.minute.toString().length == 1
        ? minuteParse
        : dateTime.minute.toString();

    String timeStr = '$hour:$minute';

    return new SizedBox(
      width: 35.0,
      child: new Text(
        timeStr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: subtitleColor, fontSize: 12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!listNoEmpty(_chatData)) return new HomeNullView();
    return new Container(
      color: Color(AppColors.BackgroundColor),
      child: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            ChatList model = _chatData[index];
            return Container(
              child: InkWell(
                onTap: () {
                  if (model.type == 'Group') {
                    routePush(new ChatPage(
                        id: model.identifier,
                        title: model.name,
                        type: model.type == 'Group' ? 2 : 1));
                  } else {
                    routePush(new ChatPage(
                        id: model.identifier.startsWith(preSuif)
                            ? model.identifier.substring(1)
                            : model.identifier,
                        title: model.name,
                        type: model.type == 'Group' ? 2 : 1));
                  }
                },
                onTapDown: (TapDownDetails details) {
                  tapPos = details.globalPosition;
                },
                onLongPress: () {
                  if (Platform.isAndroid) {
                    _showMenu(context, tapPos, model.type == 'Group' ? 2 : 1,
                        model.identifier);
                  } else {
                    debugPrint("IOS聊天长按选项功能开发中");
                  }
                },
                child: Column(
                  children: [
                    new MyConversationView(
                      imageUrl: model.type == "Group"
                          ? "assets/images/group.webp"
                          : model.avatar,
                      title: model.type == "Group"
                          ? model.name
                          : (model?.identifier?.startsWith("@")
                              ? model?.name?.substring(1)
                              : model?.name),
                      content: model?.content,
                      time: timeView(model?.time ?? 0),
                      isBorder: model?.name != _chatData[0].name,
                      unread: model.unread.toString(),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 80),
                    //   child: Divider(
                    //     height: 1,
                    //     color: Colors.grey,
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          },
          itemCount: _chatData?.length ?? 1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    PageChangeUtil.instance.disposeStream();
    canCelListener();
    super.dispose();
  }
}
