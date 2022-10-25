import 'package:dim/commom/check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_flutter/pages/circleindex/tabcircle_view/tabcircle_item_detail.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../config/logger_util.dart';
import '../../../http/Method.dart';
import '../../../httpbean/post.dart';
import '../../../httpbean/respsearchposts.dart';
import '../../../main.dart';
import '../../../tools/sp_util.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../wechat_friends/ui/item_dynamic.dart';
import 'tabcircle_view_controller.dart';

//tab 推荐 关注
class TabCircle_Page extends StatefulWidget {
  TabCircle_Page(this.type);

  int type;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabCirclePageState();
  }
}

class TabCirclePageState extends State<TabCircle_Page> with RouteAware {
  TextEditingController _searchC = new TextEditingController();
  List<Post> list = [];

  int pageNum = 1;

  RefreshController refreshController = RefreshController();

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)); //订阅
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    LoggerUtil.e("------> didPush");
    super.didPush();
    if (mounted) {
      pageNum = 1;
      listData();
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
    if (mounted) {
      pageNum = 1;
      listData();
    }
  }

  @override
  void didPushNext() {
    LoggerUtil.e("------> didPushNext");

    super.didPushNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); //取消订阅
    super.dispose();
  }

  @override
  void initState() {}

  String getUrl() {
    if (widget.type == 0) {
      return "$baseUrl/recommend_posts";
    } else if (widget.type == 1) {
      return "$baseUrl/following_posts";
    }
  }

  Widget body() {
    return SmartRefresher(
      onLoading: listData,
      enablePullDown: false,
      enablePullUp: true,
      controller: refreshController,
      child: ListView.builder(
          // separatorBuilder: (BuildContext context, int index) =>
          //     Divider(height: 1.0, color: Colors.grey),
          itemCount: list.length,
          itemBuilder: (context, index) => CircleItemDetail(
                list[index],
              )),
    );
  }

  void listData() {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");

    if(showtoast){
      showToast(context, "lat ="+SpUtil.getDouble("lat").toString() );
    }

    if (pageNum == 1) {
      list.clear();
    }

    DioUtil().post(getUrl(), data: {
      "session_id": authToken,
      "license": AppData.licence,
      "page_size": 10,
      "page_num": pageNum,
      "lat": SpUtil.getDouble("lat"),
      "lng": SpUtil.getDouble("lng"),
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      pageNum++;
      EasyLoading.dismiss();
      refreshController.loadComplete();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Respsearchposts respcountry = Respsearchposts.fromJson(data);
          // list.clear();
          if (respcountry.data != null) {
            respcountry.data.forEach((element) {
              Post p = Post.fromJson(element.toJson());
              list.add(p);
              setState(() {});
            });
          }
        } else {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: appBarColor,
      body: new SizedBox(width: double.infinity, child: body()),
    );
  }
}
