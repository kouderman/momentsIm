import 'dart:convert';

import 'package:get/get.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/tools/sp_util.dart';

import '../../../im/fun_dim_group_model.dart';
import 'Groupmember.dart';

class Manager_group_memberController extends GetxController {
  final RxList<Groupmember> memberList = RxList();
    RxList<String> list = RxList();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void getGroupMembers(String gId) {
    memberList.clear();
    DimGroup.getGroupMembersListModelLIST(gId, callback: (result) {
      List list = json.decode(result.toString().replaceAll("'", '"'));
      list.forEach((element) {
        if (element["user"].toString() != SpUtil.getString("username")) {
          memberList.add(Groupmember(user: element["user"]));
        }
      });

      // memberList.insertAll(
      //     0, json.decode(result.toString().replaceAll("'", '"')));
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
