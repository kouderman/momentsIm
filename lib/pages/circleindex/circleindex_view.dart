import 'package:dim/commom/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/pages/circleindex/tabcircle_view/tabcircle_view_view.dart';

import '../../config/const.dart';
import '../contact/childrecye/childrecye_view.dart';
import '../contact/keep_alive_wrapper.dart';
import '../wechat_friends/friendcircle/upload_circle.dart';
import '../wechat_friends/search_post/search_post_view.dart';
import 'circleindex_controller.dart';

class CircleIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndexState();
  }
}

class IndexState extends State<CircleIndexPage> with TickerProviderStateMixin {
  static List<int> indexList = [0, 1];
  TabController tabController;

  Widget getTabBar() {
    return TabBar(
        unselectedLabelColor: titleColor,

        indicatorColor: Colors.transparent,
        isScrollable: true,
        labelColor: greenColor,
        unselectedLabelStyle: TextStyle(fontSize: 16),
        labelStyle: TextStyle(fontSize: 20),
        controller: tabController,
        tabs: [
          Tab(
            text: "红人",
          ),
          Tab(
            text: "好友",
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(vsync: this, length: indexList.length);
    // final controller = Get.find<IndexLogic>();
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        flexibleSpace: SafeArea(
          child: Center(
            child: getTabBar(),
          ),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new InkWell(
                child: new Container(
                  width: 60.0,
                  child: new Image.asset('assets/images/search_black.webp'),
                ),
                onTap: () {
                  routeFadePush(new Search_postPage());
                },
              ),
              new InkWell(
                child: new Container(
                  margin: EdgeInsets.only(right: 15),
                  child: new Image.asset('assets/images/camera.png',width: 24,height: 24,),
                ),
                onTap: () {
                  routePush(ImageUploadRoute());
                },
              ),
            ],
          )
        ],
        backgroundColor: appBarColor,
      ),
      body: TabBarView(
        controller: tabController,
        children: indexList
            .map((e) => KeepAliveWrapper(
                keepAlive: false,
                child: Container(
                  child: TabCircle_Page(e),
                )))
            .toList(),
      ),
    );
  }
}
