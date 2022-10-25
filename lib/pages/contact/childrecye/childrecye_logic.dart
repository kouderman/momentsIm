import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_flutter/httpbean/recommand.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../httpbean/Resprecommand.dart';
import '../../../tools/sp_util.dart';
import '../load_state.dart';

class ChildrecyeLogic extends GetxController {
  RefreshController _refreshCon;

  int jokeType;
  int pagenum = 1;

  RefreshController get refreshCon => _refreshCon;
  final jokes = RxList<Recommand>();

  RefreshState refreshState = RefreshState.first;

  void initController(int jokeType) {
    _refreshCon = RefreshController(initialRefresh: false);
    jokes.clear();
    pagenum = 1;
    this.jokeType = jokeType;
  }

  onRefresh() {
    getData(refresh: RefreshState.refresh);
  }

  onLoading() {
    getData(refresh: RefreshState.loadMore);
  }

  String getUrl() {
    if (jokeType == 0) {
      return "$baseUrl/recommend_people";
    } else if (jokeType == 1) {
      return "$baseUrl/fetch_following";
    } else if (jokeType == 2) {
      return "$baseUrl/fetch_followers";
    }
  }

  void getData({refresh = RefreshState.first}) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post(getUrl(), data: {
      "page_size": 10,
      "page_num": pagenum,
      "lat": SpUtil.getDouble("latitude"),
      "lng": SpUtil.getDouble("longitude"),
      "user_id": SpUtil.getString("userid"),
      // "offset": 1,
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
          Resprecommand resprecommand = Resprecommand.fromJson(data);

          pagenum++;

          resprecommand.data.forEach((element) {
            jokes.add(Recommand(
                about: element.about,
                avatar: element.avatar,
                name: element.name,
                id: element.id,
                username: element.username ?? "",
                followers: element.followers,
                following: element.following.toString(),
                city: element.city,
                province: element.province,
                distance: element.distance.toString(),
                age: element.age.toString(),
                verified: element.verified,
                gender: element.gender));
          });
          refreshCon.loadComplete();
        } else {
          refreshCon.loadComplete();
          // EasyLoading.showToast(data["message"]);
        }
      }
    });
  }
}
