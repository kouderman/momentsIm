import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/httpbean/itemreply.dart';
import 'package:wechat_flutter/httpbean/respfetchlikes.dart';
import 'package:wechat_flutter/httpbean/resplike.dart';
import 'package:wechat_flutter/httpbean/resppost.dart';
import 'package:wechat_flutter/httpbean/respreplys.dart';
import 'package:wechat_flutter/pages/mine/areaevent.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../../config/appdata.dart';
import '../../../http/Method.dart';
import '../../../httpbean/Itemlike.dart';
import '../../../httpbean/resppublishdetailpost.dart';
import '../../../tools/sp_util.dart';

class Friendcircle_item_detailController extends GetxController {
  final list = RxList<Itemlike>();
  final listReply = RxList<Itemreply>();
  EventBus eventBus = EventBus();
  
  RxBool isLike = RxBool(false);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void getLikes(String postid) {
    list.clear();
    // EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/fetch_likes', data: {
      "post_id": postid,
      "session_id": authToken,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      // EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      // EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Respfetchlikes respcountry = Respfetchlikes.fromJson(data);
          list.clear();
          if (respcountry.data != null) {
            respcountry.data.forEach((element) {
              Itemlike p = Itemlike(id: element.id, avatar: element.avatar);

              list.add(p);
            });
          }
        } else {}
      }
    });
  }

  void likePost( String postId) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/like_post', data: {
      "post_id": postId,
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
          Resplike resplike = Resplike.fromJson(data);
          if (resplike.data.like) {
            list.add(Itemlike(
                id: int.parse(SpUtil.getString("userid")),
                avatar: SpUtil.getString('avatar')));
            isLike.value =true;
            list.refresh();
            // showToast(context, '点赞成功');
          } else {
            list.removeWhere((element) =>
                element.id == int.parse(SpUtil.getString("userid")));
            isLike.value =false;
            list.refresh();
            // showToast(context, '取消点赞成功');
          }
        } else {}
      }
    });
  }

  void reply(BuildContext context, String postid, String msg) {
    EasyLoading.show(status: '加载中...');
    if(showtoast){
      showToast(context, "lat ="+SpUtil.getDouble("lat").toString() );
    }
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/publish_post', data: {
      "thread_id": postid,
      "post_text": msg,
      "session_id": authToken,
      "license": AppData.licence,
      "lat": SpUtil.getDouble("lat"),
      "lng": SpUtil.getDouble("lng"),
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Resppublishdetailpost resp = Resppublishdetailpost.fromJson(data);
          showToast(context, resp.message);
          Navigator.pop(context, true);
          eventBus.fire(AreaEvent());
        } else {}
      }
    });
  }

  void deletereply(BuildContext context, String thread_id) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/delete_post', data: {
      // "thread_id": thread_id,
      "post_id": thread_id,
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
          listReply
              .removeWhere((element) => element.id.toString() == thread_id);
          listReply.refresh();
          showToast(context, data["message"].toString());
        } else {}
      }
    });
  }

  void deletepost(BuildContext context, String thread_id) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/delete_post', data: {
      // "thread_id": thread_id,
      "post_id": thread_id,
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
          Navigator.of(context).pop();
        } else {
          showToast(context, data["message"].toString());
        }
      }
    });
  }

  void getreplys(String thread_id) {
    listReply.clear();
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/thread_replys', data: {
      "thread_id": thread_id,
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
          Respreplys respcountry = Respreplys.fromJson(data);
          listReply.clear();
          if (respcountry.data != null) {
            respcountry.data.forEach((element) {
              Itemreply p = Itemreply.fromJson(element.toJson());
              listReply.add(p);
            });
          }
        } else {}
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
