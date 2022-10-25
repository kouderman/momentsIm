import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:lpinyin/lpinyin.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../httpbean/Resprecommand.dart';
import '../../im/friend_handle.dart';
import '../../im/fun_dim_group_model.dart';
import '../../tools/sp_util.dart';
import '../contact/load_state.dart';

class SelectMembersPage extends StatefulWidget {
  SelectMembersPage({this.gId, this.memberList,this.type});

  String gId;

  List memberList;
  int type =-1;

  @override
  State<StatefulWidget> createState() {
    return new _SelectMembersPageState();
  }
}

class _SelectMembersPageState extends State<SelectMembersPage> {
  List<ContactInfoModel> _contacts = List();

  int _suspensionHeight = 30;
  int _itemHeight = 60;
  double _headHeight = 60;

  int pagenum = 1;

  RefreshController _refreshCon = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    LoggerUtil.e(widget.gId);
    getData();
  }

  void getData({refresh = RefreshState.first}) {
    String authToken = SpUtil.getString("authToken");
    DioUtil().post("$baseUrl/fetch_followers", data: {
      "page_num": pagenum,
      "page_size": 10,
      "user_id": SpUtil.getString("userid"),
      // "offset": 1,
      "session_id": authToken,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      // EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      // EasyLoading.dismiss();
      print('Http response: $data');
      pagenum++;

      _refreshCon.loadComplete();
      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Resprecommand resprecommand = Resprecommand.fromJson(data);
          resprecommand.data.forEach((element) {
            LoggerUtil.e(widget.memberList);
            String username = element.username.substring(1);
            LoggerUtil.e(username);
            if (!widget.memberList.contains(username)) {
              _contacts.add(ContactInfoModel(
                  namePinyin: element.avatar,
                  tagIndex: username,
                  name: element.name,
                  id: element.id.toString()));
              // _handleList(_contacts);
              setState(() {});
            }
          });
        } else {
          // EasyLoading.showToast(data["message"]);
        }
      }
    });
  }

  List selects = [];

  void _handleList(List<ContactInfoModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(list);
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: _suspensionHeight.toDouble(),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      color: appBarColor,
      child: Text(
        '$susTag',
        textScaleFactor: 1.2,
        style: TextStyle(
          color: Color(0xff333333),
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget _buildListItem(ContactInfoModel model) {
  //   String uFace = '';
  //   String susTag = model.getSuspensionTag();
  //   return Column(
  //     children: <Widget>[
  //       Offstage(
  //         offstage: model.isShowSuspension != true,
  //         child: _buildSusWidget(susTag),
  //       ),
  //       SizedBox(
  //         height: _itemHeight.toDouble(),
  //         child: new InkWell(
  //           child: new Row(
  //             children: <Widget>[
  //               new Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: mainSpace * 1.5),
  //                 child: new Icon(
  //                   model.isSelect
  //                       ? CupertinoIcons.check_mark_circled_solid
  //                       : CupertinoIcons.check_mark_circled,
  //                   color: model.isSelect ? Colors.green : Colors.grey,
  //                 ),
  //               ),
  //               new ClipRRect(
  //                 borderRadius: BorderRadius.all(Radius.circular(5)),
  //                 child: !strNoEmpty(uFace)
  //                     ? new Image.asset(
  //                         defIcon,
  //                         height: 48.0,
  //                         width: 48.0,
  //                         fit: BoxFit.cover,
  //                       )
  //                     : CachedNetworkImage(
  //                         imageUrl: uFace,
  //                         height: 48.0,
  //                         width: 48.0,
  //                         cacheManager: cacheManager,
  //                         fit: BoxFit.cover,
  //                       ),
  //               ),
  //               new Space(),
  //               new Expanded(
  //                 child: new Container(
  //                   alignment: Alignment.centerLeft,
  //                   padding: EdgeInsets.only(right: 30),
  //                   height: _itemHeight.toDouble(),
  //                   decoration: BoxDecoration(
  //                     border: !model.isShowSuspension
  //                         ? Border(
  //                             top: BorderSide(color: lineColor, width: 0.2))
  //                         : null,
  //                   ),
  //                   child: new Text(
  //                     model.name,
  //                     style: TextStyle(fontSize: 14.0),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           onTap: () {
  //             model.isSelect = !model.isSelect;
  //             if (model.isSelect) {
  //               selects.insert(0, model);
  //               clist.insert(0, model.id);
  //             } else {
  //               selects.remove(model);
  //               clist.remove(model.id);
  //             }
  //             setState(() {});
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

  List<String> clist = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new ComMomBar(
        title: '选择联系人',
        rightDMActions: <Widget>[
          new ComMomButton(
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            onTap: () async {
              print('aaaaaaaa');
              if (!listNoEmpty(selects)) {
                showToast(context, '请选择要添加的成员');
              }

              LoggerUtil.e(clist);


              if(widget.type ==1){

                createGroupChat(clist, name: AppData.respprofile.data.userName+"发起的群聊",
                    callback: (callBack) {
                      if (callBack.toString().contains('succ')) {
                        showToast(context, '创建群组成功');
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      }
                    });

              }else {
                DimGroup.inviteGroupMember(clist, widget.gId, callback: (result) {
                  LoggerUtil.e(result.toString());
                  if (result.toString().contains("成功")) {
                    showToast(context, "邀请成员成功");
                    Navigator.of(context).pop();
                  } else {
                    showToast(context, "邀请成员失败");
                  }
                });
              }


            },
            text: '确定',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SmartRefresher(
        onLoading: getData,
        controller: _refreshCon,
        enablePullDown: false,
        enablePullUp: true,
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 1.0, color: Colors.grey),
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                activeColor: Colors.green,
                value: selects.contains(_contacts[index].id),
                tristate: false,
                onChanged: (b) {
                  LoggerUtil.e(b);
                  if (b) {
                    if (!selects.contains(_contacts[index].id)) {
                      selects.add(_contacts[index].id);
                      clist.add(_contacts[index].tagIndex);
                    }
                  } else {
                    if (selects.contains(_contacts[index].id)) {
                      selects.remove(_contacts[index].id);
                      clist.remove(_contacts[index].tagIndex);
                    }
                  }
                  setState(() {});
                },
                title: Text(_contacts[index].name),
              );
            }),
      ),
    );
  }
}

class ContactInfoModel extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;
  bool isSelect;
  String id;

  ContactInfoModel(
      {this.name = 'aTest',
      this.tagIndex = 'A',
      this.namePinyin = 'A',
      this.isSelect = false,
      this.id});

  ContactInfoModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension,
        'isSelect': isSelect,
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => " {" + " \"name\":\"" + id + "\"" + '}';
}
