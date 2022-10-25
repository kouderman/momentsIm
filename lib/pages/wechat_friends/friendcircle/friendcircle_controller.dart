import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/httpbean/resppost.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../httpbean/post.dart';
import '../../../tools/sp_util.dart';

class FriendcircleController extends GetxController {
  final list = RxList<Post>();

  final _path = "".obs;

  String get path => _path.value;

  set path(value) => _path.value = value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void getdata(String userId) {
    list.clear();
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/profile_posts', data: {
      "user_id": userId,
      "session_id": authToken,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Resppost respcountry = Resppost.fromJson(data);
          list.clear();
          if (respcountry.data.posts != null) {
            respcountry.data.posts.forEach((element) {
              Post p = Post.fromJson(element.toJson());
              list.add(p);
            });
          }
        } else {}
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    LoggerUtil.e("onClose onClose onClose");
    super.onClose();
    list.clear();
    path = "";
  }

  void delete(String postId) {
    list.removeWhere(((item) => item.id.toString() == postId));
    LoggerUtil.e("listsize ${list.length}");
    update();
  }
}
