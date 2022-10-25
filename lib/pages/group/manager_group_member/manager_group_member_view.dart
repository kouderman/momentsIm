import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../../config/const.dart';
import '../../../im/fun_dim_group_model.dart';
import '../../../ui/bar/commom_bar.dart';
import 'manager_group_member_controller.dart';

class Manager_group_memberPage extends StatelessWidget {
  String id;

  Manager_group_memberPage({this.id});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Manager_group_memberController());
    final controller = Get.find<Manager_group_memberController>();
    controller.getGroupMembers(id);
    controller.list.clear();
    var rWidget = new ComMomButton(
      text: '确定',
      style: TextStyle(color: Colors.white),
      width: 55.0,
      margin: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
      radius: 4.0,
      onTap: () => delete(controller, context, controller.list),
    );
    return FlutterEasyLoading(
      child: new Scaffold(
          backgroundColor: appBarColor,
          appBar: new ComMomBar(title: '删除成员', rightDMActions: [rWidget]),
          body: Obx(() => ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: 1.0, color: Colors.grey),
                itemCount: controller.memberList.length,
                itemBuilder: (context, index) => Obx(() => CheckboxListTile(
                      activeColor: Colors.green,
                      value: controller.list
                          .contains(controller.memberList[index].user),
                      tristate: false,
                      onChanged: (b) {
                        LoggerUtil.e(b);
                        if (b) {
                          if (!controller.list
                              .contains(controller.memberList[index].user)) {
                            controller.list
                                .add(controller.memberList[index].user);
                          }
                        } else {
                          if (controller.list
                              .contains(controller.memberList[index].user)) {
                            controller.list
                                .remove(controller.memberList[index].user);
                          }
                        }
                      },
                      title: Text(controller.memberList[index].user),
                    )),
              ))),
    );
  }

  delete(Manager_group_memberController controller, BuildContext c,
      List<String> list) {
    if (controller.list.length < 1) {
      showToast(c, "请先选择成员");
      return;
    }
    DimGroup.deleteGroupMemberModel(id, list, callback: (result) {
      if (result.toString().contains("1")) {
        showToast(c, "删除成员成功");
        controller.memberList
            .removeWhere((element) => list.contains(element.user));
        controller.memberList.refresh();
      } else {
        showToast(c, "删除成员失败");
      }
    });
  }
}
