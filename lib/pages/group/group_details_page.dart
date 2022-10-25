import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/im/friend/fun_dim_friend.dart';
import 'package:wechat_flutter/im/fun_dim_group_model.dart';
import 'package:wechat_flutter/im/group/fun_dim_info.dart';
import 'package:wechat_flutter/pages/group/group_billboard_page.dart';
import 'package:wechat_flutter/pages/group/group_member_details.dart';
import 'package:wechat_flutter/pages/group/group_members_page.dart';
import 'package:wechat_flutter/pages/group/group_remarks_page.dart';
import 'package:wechat_flutter/pages/group/select_members_page.dart';
import 'package:wechat_flutter/pages/home/home_page.dart';
import 'package:wechat_flutter/pages/home/search_page.dart';
import 'package:wechat_flutter/pages/mine/code_page.dart';
import 'package:wechat_flutter/pages/settings/chat_background_page.dart';
import 'package:wechat_flutter/tools/commom.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/dialog/confirm_alert.dart';
import 'package:wechat_flutter/ui/view/indicator_page_view.dart';

import '../../im/conversation_handle.dart';
import '../../main.dart';
import '../../routerlistener/PageChangeUtil.dart';
import '../../routerlistener/RouteEvent.dart';
import '../../ui/message_view/im_details_page.dart';
import '../root/root_page.dart';
import 'RenameDialog.dart';
import 'RenameDialogContent.dart';
import 'manager_group_member/manager_group_member_view.dart';

class GroupDetailsPage extends StatefulWidget {
  final String peer;
  final Callback callBack;

  GroupDetailsPage(this.peer, {this.callBack});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage>
    with RouteAware {

  Map<String,String> vmap = HashMap();
  /// 是否聊天置顶
  bool _top = false;

  /// 是否显示群成员昵称
  bool _showName = false;

  /// 是否保存到通讯录
  bool _contact = false;

  /// 是否免打扰
  bool _dnd = false;
  bool _see = false;

  String groupName;
  String groupNotification;
  String time;
  String cardName = '默认';

  /// 是否群的创建者
  bool isGroupOwner = false;

  /// 成员列表数据
  List memberList = [
    {'user': '+'},
//    {'user': '-'}
  ];
  List dataGroup;

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)); //订阅
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    LoggerUtil.e("------> didPush");
    super.didPush();
    if(mounted){
      _getGroupInfo();
    }
  }

  @override
  void didPop() {
    LoggerUtil.e("------> didPop");
    super.didPop();
  }

  @override
  void didPopNext() {
    LoggerUtil.e("------> didPopNext");
    super.didPopNext();
    if(mounted){
      _getGroupInfo();
    }
  }

  @override
  void didPushNext() {
    LoggerUtil.e("------> didPushNext");

    super.didPushNext();
  }

  @override
  void initState() {
    LoggerUtil.e("initState------------------");
    // WidgetsBinding.instance.addObserver(this);
    super.initState();


    getCardName();

    // PageChangeUtil.instance.changeStream.listen((event) {
    //   switch (event.type) {
    //     case ActionType.DID_REMOVE:
    //       LoggerUtil.e('ActionType.DID_REMOVE');
    //       break;
    //     case ActionType.DID_POP:
    //       LoggerUtil.e('ActionType.DID_POP');
    //       if (mounted) {
    //         LoggerUtil.e('ActionType.mounted');
    //         _getGroupMembers();
    //       }
    //       break;
    //     case ActionType.DID_PUSH:
    //       // LoggerUtil.e('ActionType.DID_PUSH');
    //       break;
    //     case ActionType.DID_REPLACE:
    //       LoggerUtil.e('ActionType.DID_REPLACE');
    //       break;
    //     default:
    //       break;
    //   }
    // });
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {}
  // }

  @override
  void dispose() {
    LoggerUtil.e('dispose -----');
    // PageChangeUtil.instance.disposeStream();
    routeObserver.unsubscribe(this); //取消订阅
    super.dispose();
  }

  getCardName() async {
    await InfoModel.getSelfGroupNameCardModel(widget.peer, callback: (str) {
      cardName = str.toString();
      setState(() {});
    });
  }

  // 获取群组信息
  _getGroupInfo() {
    DimGroup.getGroupInfoListModel([widget.peer], callback: (result) async {
      dataGroup = json.decode(result.toString().replaceAll("'", '"'));
      final user = await SharedUtil.instance.getString(Keys.account);
      isGroupOwner = dataGroup[0]['groupOwner'] == user;
      groupName = dataGroup[0]['groupName'].toString();

      String notice = strNoEmpty(dataGroup[0]['groupNotification'].toString())
          ? dataGroup[0]['groupNotification'].toString()
          : '暂无公告';
      groupNotification = notice;
      time = dataGroup[0]['groupIntroduction'].toString();
      _see = time == "1" ? true : false;
      _getGroupMembers();
      setState(() {});
    });
  }

  // 获取群成员列表
  _getGroupMembers() async {
    await DimGroup.getGroupMembersListModelLIST(widget.peer,
        callback: (result) {
      memberList.clear();
      if(isGroupOwner){
        var add = {'user': '+'};
        var dele = {'user': '-'};
        memberList.add(add);
        memberList.add(dele);
      }
      memberList.insertAll(
          0, json.decode(result.toString().replaceAll("'", '"')));
      LoggerUtil.e(memberList);
      setState(() {});
    });
  }

  List<String> buildMemList() {
    List<String> list = [];

    memberList.forEach((element) {
      list.add(element["user"]);
    });
    return list;
  }

  /// 成员item的UI序列渲染
  Widget memberItem(item) {
    List<dynamic> userInfo;
    String uId;
    String uFace = '';
    String nickName;

    /// "+" 和 "-"
    if (item['user'] == "+" || item['user'] == '-') {
      return new InkWell(
        child: new SizedBox(
          width: (winWidth(context) - 60) / 5,
          child: Image.asset(
            'assets/images/group/${item['user']}.png',
            height: 48.0,
            width: 48.0,
          ),
        ),
        onTap: () {
          if (item['user'] == "+") {
            routePush(new SelectMembersPage(
              gId: widget.peer.toString(),
              memberList: buildMemList(),type: 2,
            ));
          } else {
            routePush(new Manager_group_memberPage(
              id: widget.peer,
            ));
          }
        },

        /// "+" 和 "-" 点击之后
      );
    }
    return new FutureBuilder(
      future: DimFriend.getUsersProfile(item['user'], (cb) {
        userInfo = json.decode(cb.toString());
        uId = userInfo[0]['identifier'];
        uFace = userInfo[0]['faceUrl'];
        nickName = userInfo[0]['nickName'];

        String k = nickName.trim().toString().replaceAll(" ", "");
        vmap[k] = uId;
        LoggerUtil.e('map '+vmap[nickName.trim().toString()]);
        LoggerUtil.e('map '+ nickName.trim().toString());

      }),
      builder: (context, snap) {
        return new SizedBox(
          width: (winWidth(context) - 60) / 5,
          child: FlatButton(
            onPressed: () {
              // routePush(GroupMemberDetails(Data.user() == uId, uId)),
              if (_see == false) {
                return;
              }
              routePush(new IMDetailsPage(
                title: nickName,
                avatar: uFace,
                sid: "@" + uId,
              ));
            },
            padding: EdgeInsets.all(0),
            highlightColor: Colors.transparent,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: !strNoEmpty(uFace)
                      ? new Image.asset(
                          defIcon,
                          height: 48.0,
                          width: 48.0,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: uFace,
                          height: 48.0,
                          width: 48.0,
                          cacheManager: cacheManager,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 2),
                Container(
                  alignment: Alignment.center,
                  height: 20.0,
                  width: 50,
                  child: Text(
                    '${!strNoEmpty(nickName) ? uId : nickName.length > 4 ? '${nickName.substring(0, 3)}...' : nickName}',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 设置消息免打扰
  _setDND(int type) {
    DimGroup.setReceiveMessageOptionModel(widget.peer, Data.user(), type,
        callback: (_) {});
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    LoggerUtil.e('deactivate----');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (!listNoEmpty(dataGroup)) {
      return new Container(color: Colors.white);
    }

    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: new ComMomBar(title: '聊天信息 (${dataGroup[0]['memberNum']})'),
      body: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new ListView(
          children: <Widget>[
            new Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              width: winWidth(context),
              child: Wrap(
                runSpacing: 20.0,
                spacing: 10,
                children: memberList.map(memberItem).toList(),
              ),
            ),
            new Visibility(
              visible: memberList.length > 20,
              child: new FlatButton(
                padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                color: Colors.white,
                child: new Text(
                  '查看全部群成员',
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
                onPressed: () => routePush(new GroupMembersPage(widget.peer)),
              ),
            ),

            SizedBox(height: 10.0),
            Visibility(
                visible: isGroupOwner,
                child: functionBtn(
                  '群聊名称',
                  detail: groupName.toString().length > 7
                      ? '${groupName.toString().substring(0, 6)}...'
                      : groupName.toString(),
                )),

            Visibility(
                visible: isGroupOwner,
                child: functionBtn(
                  '群公告',
                  detail: groupNotification.toString(),
                ))
            // functionBtn(
            //   '群二维码',
            //   right: new Image.asset('assets/images/group/group_code.png',
            //       width: 20),
            // ),
            ,
            new Visibility(
              visible: false,
              child: functionBtn('群管理'),
            ),
            SizedBox(height: 10.0),
            new Visibility(
              visible: isGroupOwner,
              child: functionBtn('转让群主'),
            ),
            new Space(height: 10.0),
            // functionBtn('备注'),
            // new Space(height: 10.0),
            // functionBtn('查找聊天记录'),
            Visibility(
              visible: isGroupOwner,
              child: functionBtn('允许群查看群成员资料',
                  right: CupertinoSwitch(
                    value: _see,
                    onChanged: (bool value) {
                      _see = value;
                      setState(() {});
                      canseeprofile(_see);
                    },
                  )),
            ),

            new Space(height: 10.0),
            functionBtn('消息免打扰',
                right: CupertinoSwitch(
                  value: _dnd,
                  onChanged: (bool value) {
                    _dnd = value;
                    setState(() {});
                    value ? _setDND(1) : _setDND(2);
                  },
                )),
            functionBtn('聊天置顶',
                right: CupertinoSwitch(
                  value: _top,
                  onChanged: (bool value) {
                    _top = value;
                    setState(() {});
                    value ? _setTop(1) : _setTop(2);
                  },
                )),
            // functionBtn('保存到通讯录',
            //     right: CupertinoSwitch(
            //       value: _contact,
            //       onChanged: (bool value) {
            //         _contact = value;
            //         setState(() {});
            //         value ? _setTop(1) : _setTop(2);
            //       },
            //     )),
            new Space(height: 10.0),
            functionBtn('我在群里的昵称', detail: cardName),
            functionBtn('显示群成员昵称',
                right: CupertinoSwitch(
                  value: _showName,
                  onChanged: (bool value) {
                    _showName = value;
                    setState(() {});
                    value ? _setTop(1) : _setTop(2);
                  },
                )),
            new Space(),
            // functionBtn('设置当前聊天背景'),
            // functionBtn('投诉'),
            new Space(),
            functionBtn('清空聊天记录'),
            new Space(),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              color: Colors.white,
              onPressed: () {
                if (widget.peer == '') return;
                confirmAlert(context, (isOK) {
                  if (isOK) {
                    DimGroup.quitGroupModel(widget.peer, callback: (str) {
                      if (str.toString().contains('失败')) {
                        print('失败了，开始执行解散');
                        DimGroup.deleteGroupModel(widget.peer,
                            callback: (data) {
                          if (str.toString().contains('成功')) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                            print('解散群聊成功');
                            showToast(context, '解散群聊成功');
                          }
                        });
                      } else if (str.toString().contains('succ')) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        if (Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                        print('退出成功');
                        showToast(context, '退出成功');
                      }
                    });
                  }
                }, tips: '确定要退出本群吗？');
              },
              child: Text(
                '删除并退出',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0),
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  TextEditingController userC = new TextEditingController();

  /*
  * 点击之后的事件处理，[title]是标题，点击之后的具体事件就是通过标题来判断
  * */
  handle(String title) {
    switch (title) {
      case '备注':
        routePush(new GroupRemarksPage());
        break;
      case '转让群主':
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return RenameDialog(
                contentWidget: RenameDialogContent(
                  title: "请输入新群主的名字",
                  okBtnTap: () {
                    LoggerUtil.e(widget.peer);
                    LoggerUtil.e(vmap);
                    DimGroup.modifyGroupOwner(widget.peer, vmap[userC.text],
                        callback: (result) {
                      LoggerUtil.e(result);
                      if (result) {
                        showToast(context, "转让群主成功");
                      } else {
                        showToast(context, "转让群主失败");
                      }
                    });
                  },
                  vc: userC,
                  cancelBtnTap: () {},
                ),
              );
            });

        break;
      case '群聊名称':
        routePush(
          new GroupRemarksPage(
            groupInfoType: GroupInfoType.name,
            text: groupName,
            groupId: widget.peer,
          ),
        ).then((data) {
          LoggerUtil.e(data);
          groupName = data ?? groupName;
          setState(() {});
          Notice.send(WeChatActions.groupName(), groupName);
        });
        break;
      case '群二维码':
        routePush(new CodePage(true));
        break;
      case '群公告':
        routePush(
          new GroupBillBoardPage(
            dataGroup[0]['groupOwner'],
            groupNotification,
            groupId: widget.peer,
            time: time,
            callback: (timeData) => time = timeData,
          ),
        ).then((data) {
          groupNotification = data ?? groupNotification;
          setState(() {});
        });
        break;
      case '查找聊天记录':
        routePush(new SearchPage());
        break;
      case '消息免打扰':
        _dnd = !_dnd;
        _dnd ? _setDND(1) : _setDND(2);
        break;
      case '聊天置顶':
        _top = !_top;
        setState(() {});
        _top ? _setTop(1) : _setTop(2);
        break;
      case '设置当前聊天背景':
        routePush(new ChatBackgroundPage());
        break;
      case '我在群里的昵称':
        routePush(
          new GroupRemarksPage(
            groupInfoType: GroupInfoType.cardName,
            text: cardName,
            groupId: widget.peer,
          ),
        ).then((data) {
          cardName = data ?? cardName;
          LoggerUtil.e(cardName);
        });
        break;
      case '投诉':
        routePush(new WebViewPage(helpUrl, '投诉'));
        break;
      case '群管理':
        routePush(new Manager_group_memberPage(
          id: widget.peer,
        ));
        break;
      case '清空聊天记录':
        confirmAlert(
          context,
          (isOK) {
            if (isOK) {
              deleteConversationAndLocalMsgModel(2, widget.peer,
                  callback: (str) {
                debugPrint(
                    'deleteConversationAndLocalMsgModel' + str.toString());
              });
              delConversationModel(widget.peer, 2, callback: (str) {
                debugPrint('deleteConversationModel' + str.toString());
              });

              Navigator.of(context).pop();
              Navigator.of(context).pop();
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
            ;
          },
          tips: '确定删除群的聊天记录吗？',
          okBtn: '清空',
        );
        break;
    }
  }

  _setTop(int i) {}

  /*
  * item封装调用
  * */
  functionBtn(
    title, {
    final String detail,
    final Widget right,
  }) {
    return GroupItem(
      detail: detail,
      title: title,
      right: right,
      onPressed: () => handle(title),
    );
  }

  void canseeprofile(bool see) {
    LoggerUtil.e(see);
    DimGroup.modifyGroupIntroductionModel(widget.peer, see ? "1" : "0");
    _see = see;
  }
}

class GroupItem extends StatelessWidget {
  final String detail;
  final String title;
  final VoidCallback onPressed;
  final Widget right;

  GroupItem({
    this.detail,
    this.title,
    this.onPressed,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    if (detail == null && detail == '') {
      return new Container();
    }
    double widthT() {
      if (detail != null) {
        return detail.length > 35 ? SizeConfig.blockSizeHorizontal * 60 : null;
      } else {
        return null;
      }
    }

    bool isSwitch = title == '消息免打扰' ||
        title == '聊天置顶' ||
        title == '保存到通讯录' ||
        title == '允许群查看群成员资料' ||
        title == '显示群成员昵称';
    bool noBorder = title == '备注' ||
        // title == '查找聊天记录' ||
        title == '保存到通讯录' ||
        title == '显示群成员昵称' ||
        title == '投诉' ||
        title == '转让群主' ||
        title == '清空聊天记录';

    return FlatButton(
      padding: EdgeInsets.only(left: 15, right: 15.0),
      color: Colors.white,
      onPressed: () => onPressed(),
      child: new Container(
        padding: EdgeInsets.only(
          top: isSwitch ? 10 : 15.0,
          bottom: isSwitch ? 10 : 15.0,
        ),
        decoration: BoxDecoration(
          border: noBorder
              ? null
              : Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: Text(title),
                ),
                new Visibility(
                  visible: title != '群公告',
                  child: new SizedBox(
                    width: widthT(),
                    child: Text(
                      detail ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                right != null ? right : new Container(),
                new Space(width: 10.0),
                isSwitch
                    ? Container()
                    : Image.asset(
                        'assets/images/group/ic_right.png',
                        width: 15,
                      ),
              ],
            ),
            new Visibility(
              visible: title == '群公告',
              child: new Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  detail ?? '',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
